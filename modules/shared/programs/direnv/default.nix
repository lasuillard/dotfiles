{ lib, ... }:
let
  exampleConfigFile = ./.envrc.example;
in
{
  options.programs.direnv = {
    exampleConfig = lib.mkOption {
      type = lib.types.path;
      readOnly = true;
      description = "Path to the example direnv configuration file.";
      default = exampleConfigFile;
    };
  };

  config = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    home.file = {
      ".config/direnv" = {
        source = ./.config/direnv;
        recursive = true;
      };
    };
  };
}
