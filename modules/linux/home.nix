{
  username,
  pkgs,
  ...
}:
{
  home.username = username;
  home.homeDirectory = if username == "root" then "/root" else "/home/${username}";
  home.packages = with pkgs; [
    # TCP/IP swiss army knife (OpenBSD variant): https://salsa.debian.org/debian/netcat-openbsd
    netcat-openbsd
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
