#!/usr/bin/env sh

: '
Copy files or directories with .example suffix to the same name without the suffix,
if the target file/directory does not exist.
'

if [ ! -d '.devcontainer' ]; then
  ln --symbolic .devcontainer.example .devcontainer
fi
if [ ! -d '.vscode' ]; then
  ln --symbolic .vscode.example .vscode
fi
if [ ! -f '.env' ]; then
  cp --verbose --update=none .env.example .env
fi
