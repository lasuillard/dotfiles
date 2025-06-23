#!/usr/bin/env sh

set -o errexit
set -o nounset

# ? SC3040; pipefail is not supported in POSIX sh
# set -o pipefail

log_dir="./logs"
log_file="$log_dir/install.log"
latest_exit_code_file="$log_dir/latest_exit_code"

mkdir --parents "$log_dir"

cat <<EOT >>"$log_file"
===============================================================================
> Dotfile installation started at $(date)
===============================================================================
EOT

(
  ./linux/install.bash
  echo "$?" >"$latest_exit_code_file"
) | tee -a "$log_file"
exit_code="$(cat "$latest_exit_code_file")"
if [ "$exit_code" -ne 0 ]; then
  # ? Only print the exit status, don't propagate it
  echo "Installation failed with exit code: $exit_code"
else
  echo "Installation completed successfully."
fi
