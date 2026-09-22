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

      sops.templates.".wakatime.cfg".content = builtins.readFile (
        pkgs.replaceVars ./.wakatime.cfg {
          api_key = config.sops.placeholder."wakatime-api-key";
        }
      );

      home.file = {
        ".wakatime.cfg".source =
          config.lib.file.mkOutOfStoreSymlink
            config.sops.templates.".wakatime.cfg".path;
      };
    })
  ];
}
