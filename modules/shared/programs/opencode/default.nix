{ pkgs, llm-agents, ... }:
{
  # programs.kilo.enable = true;

  home.packages = with pkgs; [
    # OpenCode: https://opencode.ai/
    opencode
    # Kilo Code CLI: https://kilo.ai/
    # NOTE: Official CLI command is "kilo", but the llm-agents repo renames it to "kilocode"
    llm-agents.packages.${pkgs.system}.kilocode-cli
  ];

  home.file = {
    "./.config/opencode" = {
      source = .config/opencode;
      recursive = true;
    };
  };
}
