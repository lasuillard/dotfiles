{ pkgs, llm-agents, ... }:
{
  home.packages = with pkgs; [
    pkgs.skills
    # Kilo Code CLI: https://kilo.ai/
    # NOTE: Official CLI command is "kilo", but the llm-agents repo renames it to "kilocode"
    llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.kilocode-cli
  ];

  home.file = {
    "./.config/kilo" = {
      source = .config/kilo;
      recursive = true;
    };
  };
}
