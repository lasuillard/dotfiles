{
  writeShellApplication,
  writeText,
  chezmoi,
  coreutils,
  findutils,
  git,
  src,
}:
let
  configFile = writeText "agents-chezmoi.toml" "";
in
{
  agents = writeShellApplication {
    name = "agents";
    runtimeInputs = [
      coreutils
      findutils
      git
    ];
    text = builtins.replaceStrings [ "@src@" ] [ "${src}/project" ] (builtins.readFile ./agents.sh);
  };

  agents-config = writeShellApplication {
    name = "agents-config";
    runtimeInputs = [
      chezmoi
      coreutils
    ];
    text = builtins.replaceStrings [ "@src@" "@config_file@" ] [ "${src}" "${configFile}" ] (
      builtins.readFile ./agents-config.sh
    );
  };
}
