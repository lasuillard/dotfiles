{
  config,
  inputs,
  lib,
  ...
}:
let
  defaultSopsFile = builtins.toPath "${inputs.my-secrets}/secrets/main.yaml";
  ageKeyPath = builtins.toPath "${config.home.homeDirectory}/.config/sops/age/keys.txt";
in
{
  options = {
    my-secrets.enabled = lib.mkOption {
      type = lib.types.bool;
      default = builtins.pathExists defaultSopsFile;
    };
  };

  config = lib.mkIf config.my-secrets.enabled {
    sops.defaultSopsFile = defaultSopsFile;
    sops.age.keyFile = ageKeyPath;
  };
}
