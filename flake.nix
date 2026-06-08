{
  description = "Dotfiles configuration using Nix flakes and Home Manager.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Alternative packages registry
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
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
          currentUser = builtins.getEnv "USER";
          username = if currentUser == "" then "non-existing-user" else currentUser;
        in
        home-manager.lib.homeManagerConfiguration {
          pkgs = thisEnv.pkgs;
          modules = [
            ./lib/programs
            (if system == "x86_64-linux" then ./modules/linux/home.nix else ./modules/macos/home.nix)
            {
              home = {
                stateVersion = "26.05";
              };
            }
          ];
          extraSpecialArgs = {
            inherit llm-agents custompkgs username;
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
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            git
            gnumake
            pre-commit
            nixfmt
          ];
        };
      }
    );
}
