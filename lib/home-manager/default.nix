{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    bind # for dnsutils
    curl
    di
    htop
    jq
    lsof
    nettools
    rclone
    ripgrep
    rsync
    tcpdump
  ];

  home.file = {
    ".bin/shell".source = ../../user/shared/.bin/shell;
    ".copilot".source = ../../user/shared/.copilot;
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.bin/shell"
  ];
}
