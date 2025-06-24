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
files=(~/.bashrc.d/*.bash)
# shellcheck disable=SC2207
IFS=\$'\\\\n' sorted=(\$(sort <<<"\${files[*]}")); unset IFS
for f in "\${sorted[@]}"; do
  if [ ! -f "\$f" ]; then
    echo "Warning: \$f is not a regular file, skipping."
    continue
  fi
  # shellcheck disable=SC1090
  source "\$f"
done
EOT
)

replace_section ~/.bashrc "$begin" "$end" "$replacement"
