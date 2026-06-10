{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Gemini CLI: https://geminicli.com/docs/
    antigravity-cli
  ];

  home.file = {
    ".gemini" = {
      source = ./.gemini;
      recursive = true;
    };
  };
}
