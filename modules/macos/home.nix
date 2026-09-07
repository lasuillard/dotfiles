{
  username,
  pkgs,
  ...
}:
{
  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.packages = with pkgs; [
    # Utility which reads and writes data across network connections: https://netcat.sourceforge.net/
    netcat-gnu
  ];

  imports = [
    ../shared/programs/bash
    ../shared/programs/direnv
    ../shared/programs/git
    ../shared/programs/neovim
    ../shared/programs/nix
    ../shared/programs/starship
    ../shared/programs/tailscale
    ../shared/programs/tmux
    ../shared/packages.nix
  ];
}
