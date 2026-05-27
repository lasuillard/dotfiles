{ ... }:
{
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
}
