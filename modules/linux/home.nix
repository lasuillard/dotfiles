{
  username,
  pkgs,
  ...
}:
{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.packages = with pkgs; [
    netcat-openbsd
  ];

  imports = [
    ../shared/packages.nix
    ../shared/programs/bash
    ../shared/programs/direnv
    ../shared/programs/git
    ../shared/programs/starship
    ../shared/programs/tailscale
    ../shared/programs/neovim
  ];
}
