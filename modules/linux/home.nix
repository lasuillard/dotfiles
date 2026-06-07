{
  username,
  pkgs,
  ...
}:
{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.packages = with pkgs; [
    # TCP/IP swiss army knife (OpenBSD variant): https://salsa.debian.org/debian/netcat-openbsd
    netcat-openbsd
  ];

  imports = [
    ../shared/programs/bash
    ../shared/programs/direnv
    ../shared/programs/git
    ../shared/programs/github-copilot-cli
    ../shared/programs/kilo
    ../shared/programs/neovim
    ../shared/programs/starship
    ../shared/programs/tailscale
    ../shared/packages.nix
  ];
}
