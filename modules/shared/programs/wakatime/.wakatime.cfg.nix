{ config }:
''
  [settings]
  api_key = ${config.sops.placeholder."wakatime-api-key"}
''
