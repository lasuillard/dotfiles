#!/bin/sh

: '
Update dotfiles.
'

set -o errexit
set -o nounset

project_root="$(dirname "$0")"

cd "$project_root" || exit 1

echo "Fetching changes from remote..."
git fetch

echo "Checking if update is necessary..."
local_sha="$(git rev-parse HEAD)"
remote_sha="$(git rev-parse '@{u}')"
if [ "$local_sha" = "$remote_sha" ]; then
  echo "Already up to date."
  exit 0
fi

echo "Updating dotfiles (${project_root}) from repository..."
git pull --rebase
./install.sh
