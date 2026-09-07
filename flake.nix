{
  description = "Dotfiles configuration using Nix flakes and Home Manager.";

  inputs = {
    # https://search.nixos.org/packages?channel=unstable
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    # https://github.com/numtide/flake-utils
    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    # https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/nix-darwin/nix-darwin
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Alternative package registry for LLM agents and tools (more frequently updated)
    # https://github.com/numtide/llm-agents.nix
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/nix-community/nixvim
    nixvim = {
      url = "github:nix-community/nixvim";
    };

    # https://github.com/mic92/sops-nix
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # My secrets data repository
    my-secrets = {
      url = "git+ssh://git@github.com/lasuillard/secrets";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      home-manager,
      nix-darwin,
      llm-agents,
      nixvim,
      sops-nix,
      my-secrets,
      ...
    }@inputs:
    let
      mkPkgs =
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        {
          inherit pkgs;
          custompkgs = pkgs.callPackage ./lib/packages { };
        };

      mkHomeConfiguration =
        system:
        let
          thisEnv = mkPkgs system;
          custompkgs = thisEnv.custompkgs;

          # ! Require "--impure" to work to allow current user detection via environment variable
          envUser = builtins.getEnv "USER";
          username = if envUser != "" then envUser else "non-existing-user";
        in
        home-manager.lib.homeManagerConfiguration {
          pkgs = thisEnv.pkgs;
          modules = [
            sops-nix.homeManagerModules.sops
            nixvim.homeModules.nixvim
            # Register custom programs and configurations
            ./lib/programs
            (
              # OS-specific home configuration
              if system == "x86_64-linux" then
                ./modules/linux/home.nix # Linux
              else
                ./modules/macos/home.nix # macOS
            )
            {
              home = {
                stateVersion = "26.05";
              };
            }
          ];
          extraSpecialArgs = {
            inherit inputs custompkgs username;
            llm-agents = llm-agents.packages.${system};
          };
        };
    in
    # For Home Manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;

      homeConfigurations = {
        linux = mkHomeConfiguration "x86_64-linux";
        macos = mkHomeConfiguration "aarch64-darwin";
      };

      packages = {
        x86_64-linux.default = self.homeConfigurations.linux.activationPackage;
        aarch64-darwin.default = self.homeConfigurations.macos.activationPackage;
      };
    }
    # For this project tools
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages = {
          inherit (pkgs)
            git
            pre-commit
            just
            nixfmt
            shfmt
            shellcheck
            ;
        };

        devShells.default = pkgs.mkShell {
          packages = builtins.attrValues self.packages.${system};
          shellHook = ''
            pre-commit install
          '';
        };
      }
    );
}
