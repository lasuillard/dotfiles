{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # CLI for GitHub Copilot: https://github.com/github/copilot-cli
    github-copilot-cli
  ];

  home.file = {
    ".copilot" = {
      source = ./.copilot;
      recursive = true;
    };
  };
}
