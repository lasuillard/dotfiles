{ pkgs, ... }:
let
  allDirs = builtins.readDir ./.;

  packageNames = builtins.attrNames (
    pkgs.lib.attrsets.filterAttrs (name: type: type == "directory" && name != "default.nix") allDirs
  );

  customRegistry = builtins.listToAttrs (
    map (name: {
      inherit name;
      value = pkgs.callPackage (./. + "/${name}") { };
    }) packageNames
  );
in
{
  _module.args = {
    custompkgs = customRegistry;
  };
}
