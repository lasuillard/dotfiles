#!/bin/bash

: '
Dotfiles installation script for Docker environments.

This script will install the Nix package manager in a single-user configuration,
and then use Nix to set up the user profile with home-manager. It is designed to be run in a Docker container,
and it assumes that the container has either curl or wget installed for downloading the Nix installation script.

IMPORTANT: You may be prompted for your password for sudo access if /nix directory does not exists.
           if your environment does not have sudo access, you will have to ensure the /nix directory exists and has the correct permissions before running this script.
'

# Install nix package manager (single-user)
if [ "$(command -v nix)" ]; then
  echo "Nix is already installed, skipping installation"
  exit 0
fi

# Ensure /nix directory exists and has correct permissions
if [ ! -e "/nix" ]; then
  echo "Creating /nix directory..."
  sudo mkdir --mode=0755 /nix
  sudo chown "$(id -u):$(id -g)" /nix
fi

if [ "$(command -v curl)" ]; then
  echo "curl is available, using it to install Nix"
  curl --proto '=https' --tlsv1.2 --location https://nixos.org/nix/install |
    sh -s -- --no-daemon
elif [ "$(command -v wget)" ]; then
  echo "wget is available, using it to install Nix"
  wget https://nixos.org/nix/install --output-document - |
    sh -s -- --no-daemon
else
  echo "Error: Neither curl nor wget is available. Please install one of them to proceed with Nix installation."
  exit 1
fi

# Activate nix in the current shell session and for future sessions
nix_sh="${HOME}/.nix-profile/etc/profile.d/nix.sh"
# shellcheck disable=SC1090
. "$nix_sh"
cat <<BASHRC >>~/.bashrc
if [ -e "$nix_sh" ]; then
  . "$nix_sh";
fi
BASHRC

# Setup user profile with home-manager
nix run --extra-experimental-features 'nix-command flakes' \
  home-manager -- \
  --extra-experimental-features 'nix-command flakes' \
  --flake \
  'path:.#linux' \
  --impure \
  -b backup \
  switch
