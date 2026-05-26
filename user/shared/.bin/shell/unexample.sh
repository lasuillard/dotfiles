#!/usr/bin/env sh

: '
Copy files or directories with .example suffix to the same name without the suffix,
if the target file/directory does not exist.
'

if [ ! -d '.devcontainer' ]; then
  echo 'Linking .devcontainer to .devcontainer.example'
  ln --symbolic .devcontainer.example .devcontainer
fi
if [ ! -d '.vscode' ]; then
  echo 'Linking .vscode to .vscode.example'
  ln --symbolic .vscode.example .vscode
fi
if [ ! -f '.env' ]; then
  echo 'Copying .env.example from .env'
  cp --verbose --update=none .env.example .env
fi
if [ ! -f '.envrc' ]; then
  echo 'Creating new .envrc file'
  cat <<ENVRC >.envrc
# Uncomment below to load .env file automatically
# See https://direnv.net/man/direnv-stdlib.1.html for other useful functions
# dotenv_if_exists .env
ENVRC
fi
