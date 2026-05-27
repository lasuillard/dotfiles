{
  username,
  pkgs,
  ...
}:
{
  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.packages = with pkgs; [

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
