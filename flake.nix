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
      mkHomeConfig =
        { system }:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          custompkgs = pkgs.callPackage ./lib/packages { };

          # IMPURE: derive the username from the environment variable USER
          envUser = builtins.getEnv "USER";
          username = if envUser != "" then envUser else "non-existing-user";
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            sops-nix.homeManagerModules.sops
            nixvim.homeModules.nixvim
            # Register custom programs and configurations
            ./lib/programs
            (if pkgs.stdenv.hostPlatform.isLinux then ./modules/linux/home.nix else ./modules/macos/home.nix)
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
    {
      homeConfigurations = {
        "default" = mkHomeConfig { system = builtins.currentSystem; };
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages = {
          # Tools to be executed in CI/CD pipelines
          inherit (pkgs)
            nixfmt
            shfmt
            shellcheck
            ;

          default = self.homeConfigurations."default".activationPackage;
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            git
            pre-commit
            just
            nixfmt
            shfmt
            shellcheck
          ];
          shellHook = ''
            pre-commit install
          '';
        };
      }
    );
}
