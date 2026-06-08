{ pkgs, ... }:
{
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
}
