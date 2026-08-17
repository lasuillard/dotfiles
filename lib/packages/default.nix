{ pkgs, ... }:
{
  openskills = pkgs.callPackage ./openskills { };
  wtp = pkgs.callPackage ./wtp { };
}
