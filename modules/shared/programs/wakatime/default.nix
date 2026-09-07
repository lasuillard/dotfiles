{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkMerge [
    {
      home.packages = with pkgs; [
        wakatime-cli
      ];
    }
    (lib.mkIf config.my-secrets.enabled {
      sops.secrets."wakatime-api-key" = { };

      sops.templates.".wakatime/.wakatime.cfg".content = import ./.wakatime/.wakatime.cfg.nix {
        inherit config;
      };

      home.file = {
        ".wakatime/.wakatime.cfg".source =
          config.lib.file.mkOutOfStoreSymlink
            config.sops.templates.".wakatime/.wakatime.cfg".path;
      };
    })
  ];
}
