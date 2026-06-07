{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pkgs.skills
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
