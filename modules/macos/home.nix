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
    ../shared/programs/github-copilot-cli
    ../shared/programs/neovim
    ../shared/programs/opencode
    ../shared/programs/starship
    ../shared/programs/tailscale
    ../shared/packages.nix
  ];
}
