#!/usr/bin/env bash

set -o errexit
set -o nounset

: '
Copy files or directories with .example suffix to the same name without the suffix,
if the target file/directory does not exist.
'

usage() {
  cat <<USAGE
Usage: $0 [--help] {init|unlink}

Global options
  -h, --help    Show this message

Subcommands:
  init:         Initialize example files
  unlink:       Replace symlinked example files with actual files
  merge:        Merge symlinked example files with actual files to follow changes
USAGE
}

# Global options
while [[ $# -gt 0 ]]; do
  case $1 in
  -h | --help)
    usage
    exit 0
    ;;
  *)
    break
    ;;
  esac
done

# Subcommands
if [[ $# -lt 1 ]]; then
  echo "Error: Missing subcommand." >&2
  echo
  usage
  exit 1
fi

subcommand="$1"
shift

_init() {
  # Dev Container (follow project configuration)
  if [ ! -d '.devcontainer' ] && [ -d '.devcontainer.example' ]; then
    echo 'Linking .devcontainer to .devcontainer.example'
    ln --symbolic .devcontainer.example .devcontainer
  fi

  # VS Code (follow project configuration)
  if [ ! -d '.vscode' ] && [ -d '.vscode.example' ]; then
    echo 'Linking .vscode to .vscode.example'
    ln --symbolic .vscode.example .vscode
  fi

  # .env
  if [ ! -f '.env' ] && [ -f '.env.example' ]; then
    echo 'Copying .env.example from .env'
    cp --verbose --update=none .env.example .env
  fi

  # .envrc (direnv)
  if [ ! -f '.envrc' ]; then
    if [ -f '.envrc.example' ]; then
      echo 'Copying .envrc.example from .envrc'
      cp --verbose --update=none .envrc.example .envrc
    else
      echo 'Creating new .envrc file'
      cat <<EOF >.envrc
# See https://direnv.net/man/direnv-stdlib.1.html for other useful functions

if [ ! "\$(is_devcontainer)" = "true" ]; then
  use flake
fi

dotenv_if_exists .env
EOF
    fi
  fi

  # Development environment management with Nix Flakes
  # ? Previously used shell.nix (nix-shell) but changed to flake.nix
  # ? for more flexible and reproducible environment management
  if [ ! -f 'flake.nix' ]; then
    cat <<EOF >flake.nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages = {
          inherit (pkgs)
            pre-commit
            just
            ;
        };

        devShells.default = pkgs.mkShell {
          packages = builtins.attrValues self.packages.\${system};
          shellHook = ''
            pre-commit install
          '';
        };
      }
    );
}
EOF
  fi
}

_unlink() {
  if [ -L .devcontainer ]; then
    echo 'Unlinking .devcontainer'
    rm .devcontainer
    cp --recursive .devcontainer.example .devcontainer
  fi
  if [ -L .vscode ]; then
    echo 'Unlinking .vscode'
    rm .vscode
    cp --recursive .vscode.example .vscode
  fi
}

_merge() {
  if [ -f .devcontainer/devcontainer.json ]; then
    echo 'Merging .devcontainer/devcontainer.json'
    cp --recursive --update=none .devcontainer.example .devcontainer
    jq --slurp '.[0] * .[1]' .devcontainer.example/devcontainer.json .devcontainer/devcontainer.json >.devcontainer/devcontainer.json.tmp
    mv .devcontainer/devcontainer.json.tmp .devcontainer/devcontainer.json
  fi
  if [ -f .vscode/settings.json ]; then
    echo 'Merging .vscode'
    cp --recursive --update=none .vscode.example .vscode
    jq --slurp '.[0] * .[1]' .vscode.example/settings.json .vscode/settings.json >.vscode/settings.json.tmp
    mv .vscode/settings.json.tmp .vscode/settings.json
  fi
}

case "$subcommand" in
init)
  _init
  ;;
unlink)
  _unlink
  ;;
merge)
  _merge
  ;;
*)
  echo "Unknown subcommand: ${subcommand}" >&2
  exit 1
  ;;
esac
