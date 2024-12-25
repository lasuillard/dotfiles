#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

begin="#bashrc-d-register@start"
end="#bashrc-d-register@end"

# Check if the snippet is already in the .bashrc
n_begin=$(awk "/${begin}/{print NR; exit}" ~/.bashrc)
n_end=$(awk "/${end}/{print NR; exit}" ~/.bashrc)

# Remove the old snippet
sed -i "${n_begin},${n_end}d" ~/.bashrc || true

# Add the new snippet
cat <<EOT >>~/.bashrc
$begin
for f in ~/.bashrc.d/*.sh; do
    source "\$f"
done
$end
EOT
