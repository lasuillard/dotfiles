{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Codex CLI: https://developers.openai.com/codex/cli
    codex
  ];

  home.file = {
    ".codex" = {
      source = ./.codex;
      recursive = true;
    };
  };
}
