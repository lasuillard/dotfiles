{ ... }:
{
  home.file = {
    ".config/direnv" = {
      source = ./.config/direnv;
      recursive = true;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
