{
  description = "Dotfiles configuration using Nix flakes and Home Manager.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }@inputs:
    let
      # Require "--impure" to work to allow current user detection via environment variable
      currentUser = builtins.getEnv "USER";

    in {
      homeConfigurations = {
        linux = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./lib/home-manager/default.nix
            ./modules/linux/home.nix
            {
              home = {
                stateVersion = "25.05";
              };
            }
          ];
          extraSpecialArgs = {
            username = currentUser;
          };
        };
        macos = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          modules = [
            ./lib/home-manager/default.nix
            ./modules/macos/home.nix
            {
              home = {
                stateVersion = "25.05";
              };
            }
          ];
        };
      };

      packages = {
        x86_64-linux.default = self.homeConfigurations.linux.activationPackage;
        aarch64-darwin.default = self.homeConfigurations.macos.activationPackage;
      };
    };
}
