#!/bin/sh

# Install nix package manager (single-user)
if [ $(command -v nix) ]; then
  echo "Nix is already installed, skipping installation"
else
  if [ $(command -v curl) ]; then
    echo "curl is available, using it to install Nix"
    curl --proto '=https' --tlsv1.2 --location https://nixos.org/nix/install |
      sh -s -- --no-daemon
  elif [ $(command -v wget) ]; then
    echo "wget is available, using it to install Nix"
    wget https://nixos.org/nix/install --output-document - |
      sh -s -- --no-daemon
  else
    echo "Error: Neither curl nor wget is available. Please install one of them to proceed with Nix installation."
    exit 1
  fi
fi

echo 'source "${HOME}/.nix-profile/etc/profile.d/nix.sh"' >>~/.bashrc
source "${HOME}/.nix-profile/etc/profile.d/nix.sh"

nix build --extra-experimental-features 'nix-command flakes' .
