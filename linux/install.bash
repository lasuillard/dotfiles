#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

find linux/tasks -name "*.bash" | sort | while read -r task; do
  if [ -f "$task" ]; then
    echo "Running task: $task"
    # shellcheck disable=SC1090
    source "$task"
  else
    echo "Task file not found: $task"
  fi
done
