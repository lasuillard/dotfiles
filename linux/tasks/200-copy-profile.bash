#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

echo "Linking profile files..."

symlinks=(
  ".bashrc.d"
  ".bin"
  ".vimrc"
  ".gitconfig"
  ".gitignore"
  ".gitattributes"
)

for sl in "${symlinks[@]}"; do
  if [ -e "$HOME/$sl" ] && [ ! -L "$HOME/$sl" ]; then
    echo "File $sl already exists and is not a symlink. Skipping."
    continue
  fi
  echo "(Re)linking $sl..."
  ln --symbolic --force --target-directory "$HOME" "$(pwd)/profile/$sl"
done
