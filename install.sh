#!/usr/bin/env sh

log_dir="./logs"

mkdir --parents "$log_dir"
./linux/install.bash | tee -a "$log_dir/install.log"
