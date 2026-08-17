{
  config,
  lib,
  custompkgs,
  ...
}:
let
  cfg = config.programs.wtp;
in
{
  options.programs.wtp = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to install wtp.";
    };
  };

  config = lib.mkIf cfg.enable {
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
