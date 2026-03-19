#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

echo "Linking profile files..."

symlinks=(
  ".bashrc.d"
  ".bin"
  ".copilot/agents"
  ".copilot/instructions"
  ".copilot/prompts"
  ".gitattributes"
  ".gitconfig"
  ".gitignore"
  ".vimrc"
  ".config/direnv"
)

for sl in "${symlinks[@]}"; do
  echo "(Re)linking $sl..."
  if [ -e "${HOME}/${sl}" ] && [ ! -L "${HOME}/${sl}" ]; then
    echo "File $sl already exists and is not a symlink. Skipping."
    continue
  fi

  if [ "$(dirname "$sl")" == "." ]; then
    basepath="$HOME"
  else
    echo "Provided symlink ${sl} is in a subdirectory, ensuring base path exists..."
    basepath="${HOME}/$(dirname "$sl")"
    mkdir --parents "${HOME}/$(dirname "$sl")"
  fi

  ln --symbolic --force --target-directory "$basepath" "$(pwd)/profile/${sl}"
  echo "Linked ${sl}."
done
