{ pkgs, ... }:
{
  home.packages = with pkgs; [
    github-copilot-cli
  ];

  home.file = {
    ".copilot" = {
      source = ./.copilot;
      recursive = true;
    };
  };
}
