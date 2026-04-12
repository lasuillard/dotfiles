#!/usr/bin/env bash

# https://github.com/direnv/direnv/issues/550
if [ -n "${DIRENV_DISABLE-}" ]; then
  echo "direnv is disabled via DIRENV_DISABLE"
  exit
else
  cat <<EOT
direnv is enabled. To disable direnv temporarily, set \$DIRENV_DISABLE:

  export DIRENV_DISABLE=1 && direnv reload

to re-enable it, run:

  export DIRENV_DISABLE= && direnv reload

EOT
fi
