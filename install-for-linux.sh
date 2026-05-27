#!/bin/sh

: '
Dotfiles installation script for Linux environments.

Requirements:
- Either curl or wget to download the Nix installation script.

This script will install the Nix package manager as a multi-user configuration,
and then use Nix to set up the user profile with home-manager.
'

# Install nix package manager (multi-user)
if command -v nix >/dev/null 2>&1; then
  echo "Nix is already installed, skipping installation"
else
  # Install Nix using either curl or wget, depending on which is available
  if command -v curl >/dev/null 2>&1; then
    echo "curl is available, using it to install Nix"
    curl --proto '=https' --tlsv1.2 --location https://nixos.org/nix/install |
      sh -s --
  elif command -v wget >/dev/null 2>&1; then
    echo "wget is available, using it to install Nix"
    wget https://nixos.org/nix/install --output-document - |
      sh -s --
  else
    echo "Error: Neither curl nor wget is available. Please install one of them to proceed with Nix installation."
    exit 1
  fi
fi

# Verify that nix is installed and available in the PATH
nix --version

# Setup user profile with home-manager
nix run \
  --extra-experimental-features 'nix-command flakes' \
  home-manager \
  -- \
  --extra-experimental-features 'nix-command flakes' \
  --flake \
  'path:.#linux' \
  --impure \
  -b backup \
  switch
