#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

echo "Installing packages with APT..."

if sudo --non-interactive true; then
  sudo apt update && sudo apt install --yes \
    bash-completion \
    curl \
    di \
    dnsutils \
    htop \
    jq \
    lsof \
    net-tools \
    netcat-openbsd \
    rclone \
    rsync \
    tcpdump \
    vim

  echo "Packages installed successfully."
else
  echo "Have no sudo privileges, skipping package installation."
fi
