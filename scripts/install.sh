#!/bin/sh

: '
Dotfiles installation script with auto-detection of the operating system. Then it delegates to OS-specific scripts.
'

set -o errexit
set -o nounset

project_root="$(git rev-parse --show-toplevel)"
arch="$(uname -s)"

cd "$project_root" || exit 1

# ? In certain environments (e.g., Docker containers), $USER may not be set automatically
# ? so we need to ensure it's set before proceeding
# ? Maybe related: https://github.com/nix-community/home-manager/issues/3944
if [ -z "${USER:-}" ]; then
  echo "USER environment variable is not set, setting it to the current user: whoami: $(whoami), id: $(id)"
  USER="$(whoami)"
  export USER
fi

# Function to check if we're running in a Docker container by evaluating common indicators
is_docker() {
  if grep --quiet docker /proc/1/cgroup; then
    echo "true"
    return
  fi
  if [ -f "/.dockerenv" ]; then
    echo "true"
    return
  fi
  echo "false"
}

# Check if we're running in a Docker container
if [ "$(is_docker)" = "true" ]; then
  echo "Detected Docker environment, running Docker-specific installation script"
  sh "${project_root}/scripts/install-for-docker.sh"
  exit 0
fi

# If not in Docker, proceed with OS detection and installation
case "$arch" in
Linux*)
  echo "Detected Linux OS, running Linux-specific installation script"
  sh "${project_root}/scripts/install-for-linux.sh"
  exit 0
  ;;
Darwin*)
  echo "Detected macOS, running macOS-specific installation script"
  sh "${project_root}/scripts/install-for-macos.sh"
  exit 0
  ;;
*)
  echo "Unsupported OS: $arch"
  exit 1
  ;;
esac
