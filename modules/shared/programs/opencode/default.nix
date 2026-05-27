{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # OpenCode: https://opencode.ai/
    opencode
  ];

  home.file = {
    "./.config/opencode" = {
      source = .config/opencode;
      recursive = true;
    };
  };
}
