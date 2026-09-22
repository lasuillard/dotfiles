{
  config,
  lib,
  custompkgs,
  ...
}:
let
  exampleConfigFile = ./.wtp.yml.example;
in
{
  options.programs.wtp = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to install wtp.";
    };
    exampleConfig = lib.mkOption {
      type = lib.types.path;
      readOnly = true;
      description = "Path to the example wtp configuration file.";
      default = exampleConfigFile;
    };
  };

  config = lib.mkIf config.programs.wtp.enable {
    home.packages = [
      # Git worktree manager: https://github.com/satococoa/wtp
      custompkgs.wtp
    ];
    programs.bash = {
      initExtra = ''
        eval "$(${lib.getExe custompkgs.wtp} shell-init bash)"
      '';
    };
  };
}
