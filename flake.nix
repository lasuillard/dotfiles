{
  description = "Dotfiles managed via Home Manager and Nix flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      mkHomeConfig = { system, username }: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./lib/home-manager-module.nix
          {
            home = {
              inherit username;
              homeDirectory = if nixpkgs.lib.hasInfix "darwin" system then "/Users/${username}" else "/home/${username}";
              stateVersion = "24.05";
            };
          }
        ];
      };
    in {
      homeConfigurations = {
        "linux" = mkHomeConfig { system = "x86_64-linux"; username = "lasuillard"; };
        "macos" = mkHomeConfig { system = "aarch64-darwin"; username = "lasuillard"; };
      };

      packages = {
        x86_64-linux.default = self.homeConfigurations."linux".activationPackage;
        aarch64-darwin.default = self.homeConfigurations."macos".activationPackage;
      };
    };
}
