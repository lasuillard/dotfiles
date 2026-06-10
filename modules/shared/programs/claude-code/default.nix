{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Claude Code: https://code.claude.com/docs/en/overview
    claude-code
  ];

  home.file = {
    ".claude" = {
      source = ./.claude;
      recursive = true;
    };
  };
}
