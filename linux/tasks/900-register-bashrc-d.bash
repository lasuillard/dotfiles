#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

source "$(pwd)/lib/file.bash"

echo "Registering bashrc.d hook in ~/.bashrc file..."

begin="#bashrc-d-register@start"
end="#bashrc-d-register@end"
replacement=$(
  cat <<EOT
find -L ~/.bashrc.d -name "*.bash" | sort | while read -r f; do
    source "\$f"
done
EOT
)
replace_section ~/.bashrc "$begin" "$end" "$replacement"
