{
  description = "Dotfiles configuration using Nix flakes and Home Manager.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      llm-agents,
      home-manager,
      nix-darwin,
      ...
    }@inputs:
    let
      commonModules = [
        ./lib/programs
      ];

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

      linuxEnv = mkPkgs "x86_64-linux";
      macosEnv = mkPkgs "aarch64-darwin";

      # Require "--impure" to work to allow current user detection via environment variable
      currentUser = builtins.getEnv "USER";
    in
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;

      homeConfigurations = {
        linux = home-manager.lib.homeManagerConfiguration {
          pkgs = linuxEnv.pkgs;
          modules = with commonModules; [
            ./modules/linux/home.nix
            {
              home = {
                stateVersion = "26.05";
              };
            }
          ];
          extraSpecialArgs = {
            username = currentUser;
            inherit llm-agents;
            custompkgs = linuxEnv.custompkgs;
          };
        };
        macos = home-manager.lib.homeManagerConfiguration {
          pkgs = macosEnv.pkgs;
          modules = with commonModules; [
            ./modules/macos/home.nix
            {
              home = {
                stateVersion = "26.05";
              };
            }
          ];
          extraSpecialArgs = {
            username = currentUser;
            inherit llm-agents;
            custompkgs = macosEnv.custompkgs;
          };
        };
      };

      packages = {
        x86_64-linux.default = self.homeConfigurations.linux.activationPackage;
        aarch64-darwin.default = self.homeConfigurations.macos.activationPackage;
      };
    };
}
