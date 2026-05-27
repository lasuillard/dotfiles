{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # WireGuard-based mesh VPN: https://tailscale.com/
    tailscale
  ];
}
