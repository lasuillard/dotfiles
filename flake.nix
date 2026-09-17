{
  description = "Dotfiles configuration using Nix flakes and Home Manager.";

  inputs = {
    # https://search.nixos.org/packages?channel=26.05
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-26.05";
    };

    # https://github.com/numtide/flake-utils
    flake-utils = {
      url = "github:numtide/flake-utils/main";
    };

    # https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/nix-darwin/nix-darwin
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/nix-community/nixvim
    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
      # Don't follow nixpkgs for nixvim is tested against its own pinned nixpkgs
    };

    # https://github.com/mic92/sops-nix
    sops-nix = {
      url = "github:Mic92/sops-nix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # My secrets data repository
    # https://github.com/lasuillard/secrets
    my-secrets = {
      url = "git+ssh://git@github.com/lasuillard/secrets?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # My agents configuration
    # https://github.com/lasuillard/agents
    my-agents = {
      url = "git+ssh://git@github.com/lasuillard/agents?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      home-manager,
      nix-darwin,
      nixvim,
      sops-nix,
      my-secrets,
      my-agents,
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
            my-agents.homeModules.default
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
