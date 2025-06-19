#!/usr/bin/env bash

# FIXME: Temporary workaround for SSH configuration conflicts with GPG in GitHub Codespaces
if [ ! "$CODESPACES" ]; then
  exit 0
fi

echo 'Current environment looks like GitHub Codespaces.'
echo 'Applying temporary workaround for Git SSH configuration with GPG...'
git config --global --unset user.signingkey
git config --global --unset gpg.format
git config --global --unset 'url.git@github.com:.insteadof'
