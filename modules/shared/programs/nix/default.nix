{ lib, pkgs, ... }:
let
  exampleConfigFile = ./flake.nix.example;
in
{
  options.programs.nix = {
    exampleConfig = lib.mkOption {
      type = lib.types.path;
      readOnly = true;
      description = "Path to the example Nix flake configuration file.";
      default = exampleConfigFile;
    };
  };

  config = {
    home.packages = with pkgs; [
      # Official formatter for Nix code
      nixfmt
    ];

    home.file = {
      ".config/nix" = {
        source = ./.config/nix;
        recursive = true;
      };
    };
  };
}
