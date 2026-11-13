{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  llm-agents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
  agentPrograms = pkgs.callPackage ./packages.nix { src = inputs.my-agents; };
  agentsConfig = agentPrograms.agents-config;
in
{
  home.packages =
    (with pkgs; [
      jq
      chezmoi
      skills
      github-copilot-cli
    ])
    ++ (with llm-agents; [
      antigravity-cli
      claude-code
      codex
    ])
    ++ [
      agentPrograms.agents
      agentsConfig
    ];

  home.activation.applyAgents = lib.hm.dag.entryAfter [ "linkGeneration" "installPackages" ] ''
    run ${agentsConfig}/bin/agents-config --no-tty apply < /dev/null
  '';
}
