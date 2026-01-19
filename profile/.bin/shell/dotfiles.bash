#!/usr/bin/env bash

: '
Dotfiles management script.
'

root_dir="$(realpath "$(dirname "$0")/../../..")"

function show_logs() {
  log_dir="${root_dir}/logs"
  if [ ! -d "${log_dir}" ]; then
    echo "Log directory ${log_dir} does not exist."
    exit 1
  fi
  tail --lines 1000 "${log_dir}/install.log" | more
}

function update() {
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
