{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  packages = [
    pkgs.git
    pkgs.gnumake
    pkgs.nixfmt
    pkgs.pre-commit
  ];
}
