{ pkgs, ... }:
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
    ".copilot".source = ../../user/shared/.copilot;
  };
}
