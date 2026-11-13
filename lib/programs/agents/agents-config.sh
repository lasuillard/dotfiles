#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

src="@src@"
config_file="@config_file@"

state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/chezmoi-agents"
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/chezmoi-agents"
mkdir --parents "$state_dir" "$cache_dir"

if [[ $# -eq 0 ]]; then
  set -- diff
fi

exec chezmoi \
  --source "$src" \
  --destination "$HOME" \
  --config "$config_file" \
  --persistent-state "${state_dir}/state.boltdb" \
  --cache "$cache_dir" \
  "$@"
