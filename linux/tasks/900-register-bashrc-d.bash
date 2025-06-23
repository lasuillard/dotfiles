#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$(pwd)/lib/file.bash"

echo "Registering bashrc.d hook in ~/.bashrc file..."

begin="#bashrc-d-register@start"
end="#bashrc-d-register@end"
replacement=$(
  # shellcheck disable=SC2012 # ? `find` doesn't work as I expected...
  cat <<EOT
for f in \$(ls -1 ~/.bashrc.d/*.bash | sort); do
  source "\$f"
done
EOT
)
replace_section ~/.bashrc "$begin" "$end" "$replacement"
