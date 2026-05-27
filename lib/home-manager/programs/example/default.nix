# Example program module installing cowsay.
#
# You can use this module like this:
#   programs.example.enable = true;
#
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.example;
in
{
  options.programs.example = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to install cowsay.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      # Classic configurable talking cows: https://cowsay.diamonds/
      pkgs.cowsay
    ];
  };
}
