{
  writeShellApplication,
  writeText,
  chezmoi,
  coreutils,
  src,
}:
let
  configFile = writeText "agents-chezmoi.toml" "";
in
{
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
