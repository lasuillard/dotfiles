#!/usr/bin/env bash

: '
Dotfiles management script.
'

function show_logs() {
  tail --lines 1000 ./logs/install.log | more
}

function update() {
  root_dir="$(realpath "$(dirname "$0")/../..")"
  cd "$root_dir" || exit 1
  echo "Updating dotfiles (${root_dir}) from repository..."
  git pull --rebase
  ./install.sh
}

case "$1" in
logs)
  show_logs
  ;;
update)
  update "$@"
  ;;
*)
  cat <<USAGE
Usage: $0 {logs|update}

Commands:
  logs: Show the last 1000 lines of the install log
  update: Update the dotfiles

USAGE
  ;;
esac
