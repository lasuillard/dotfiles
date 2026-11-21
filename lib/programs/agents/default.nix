{
  pkgs,
  inputs,
  ...
}:
let
  llm-agents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  home.packages =
    (with pkgs; [
      jq
      skills
      github-copilot-cli
    ])
    ++ (with llm-agents; [
      antigravity-cli
      claude-code
      codex
    ]);
}
