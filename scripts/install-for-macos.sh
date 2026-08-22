#!/bin/sh

: '
Dotfiles installation script for macOS environments.

Requirements:
- curl (macOS default) to download the Nix installation script.

This script will install the Nix package manager as a multi-user configuration,
and then use Nix to set up the user profile with home-manager.
'

set -o errexit
set -o nounset

# Install nix package manager (multi-user)
if command -v nix >/dev/null 2>&1; then
  echo "Nix is already installed, skipping installation: $(nix --version)"
else
  # Install Nix using either curl or wget, depending on which is available
  if command -v curl >/dev/null 2>&1; then
    echo "curl is available, using it to install Nix"
    echo
    curl --proto '=https' --tlsv1.2 --location https://nixos.org/nix/install |
      sh -s --
    echo
  else
    echo "Error: curl is not available. Please install curl to proceed with Nix installation."
    exit 1
  fi
fi

# Setup user profile with home-manager
echo
nix run \
  --extra-experimental-features 'nix-command flakes' \
  home-manager \
  -- \
  --extra-experimental-features 'nix-command flakes' \
  --flake \
  'path:.#macos' \
  --impure \
  -b backup \
  switch
