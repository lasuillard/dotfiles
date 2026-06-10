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
    ../shared/programs/antigravity-cli
    ../shared/programs/bash
    ../shared/programs/claude-code
    ../shared/programs/codex-cli
    ../shared/programs/direnv
    ../shared/programs/git
    ../shared/programs/github-copilot-cli
    ../shared/programs/kilo
    ../shared/programs/neovim
    ../shared/programs/nix
    ../shared/programs/starship
    ../shared/programs/tailscale
    ../shared/packages.nix
  ];
}
