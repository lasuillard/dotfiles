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
            nixvim.homeModules.nixvim
            ./lib/programs
            (if pkgs.stdenv.hostPlatform.isLinux then ./modules/linux/home.nix else ./modules/macos/home.nix)
            {
              home = {
                stateVersion = "26.05";
              };
            }
          ];
          extraSpecialArgs = {
            inherit custompkgs username;
            llm-agents = llm-agents.packages.${system};
          };
        };
    in
    {
      homeConfigurations = {
        "x86_64-linux" = mkHomeConfig { system = "x86_64-linux"; };
        "aarch64-darwin" = mkHomeConfig { system = "aarch64-darwin"; };
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

          default =
            if system == "x86_64-linux" then
              self.homeConfigurations."x86_64-linux".activationPackage
            else if system == "aarch64-darwin" then
              self.homeConfigurations."aarch64-darwin".activationPackage
            else
              throw "Unsupported system: ${system}";
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
