#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

: '
Agents management script.
'

src="@src@"

usage() {
  cat <<USAGE
Usage: $0 [--help] {init|update|sync}

Global options
  -h, --help    Show this message

Subcommands:
  init:         Initialize the agents files
  update:       Update the agents files
  sync:         Synchronize the agents files, overwriting any local changes
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

pwd="$(pwd)"
agents_dir="${pwd}/.agents"

is_git_repo=$(git rev-parse --is-inside-work-tree 2>/dev/null || true)

_init() {
  echo "Initializing agents at ${agents_dir}"
  if [ -d "$agents_dir" ]; then
    echo "Agents directory already exists, skipping initialization."
    return 0
  fi
  cp --recursive --no-target-directory --update=none "${src}" "${agents_dir}"
  find "$agents_dir" -type d -exec chmod 755 {} +
  find "$agents_dir" -type f -exec chmod 644 {} +
  if [ "$is_git_repo" = "true" ]; then
    echo '/.agents' >>.git/info/exclude
  fi
  if [ -f .envrc ]; then
    echo 'agents update' >>.envrc
  fi
}

_update() {
  echo "Updating agents in ${agents_dir}"
  cp --recursive --no-target-directory --update=none "${src}" "${agents_dir}"
  find "$agents_dir" -type d -exec chmod 755 {} +
  find "$agents_dir" -type f -exec chmod 644 {} +
}

_sync() {
  echo "Synchronizing agents in ${agents_dir}"
  rm --recursive --force "${agents_dir}"
  cp --recursive --no-target-directory "${src}" "${agents_dir}"
  find "$agents_dir" -type d -exec chmod 755 {} +
  find "$agents_dir" -type f -exec chmod 644 {} +
}

case "$subcommand" in
init)
  _init
  ;;
update)
  _update
  ;;
sync)
  _sync
  ;;
*)
  echo "Unknown subcommand: ${subcommand}" >&2
  exit 1
  ;;
esac
