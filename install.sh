#!/bin/sh

: '
Dotfiles installation script with auto-detection of the operating system. Then it delegates to OS-specific scripts.
'

arch="$(uname -s)"

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
  sh install-for-docker.sh
  exit 0
fi

# If not in Docker, proceed with OS detection and installation
case "$arch" in
Linux*)
  echo "Detected Linux OS, running Linux-specific installation script"
  sh install-for-linux.sh
  exit 0
  ;;
Darwin*)
  echo "Detected macOS, running macOS-specific installation script"
  sh install-for-macos.sh
  exit 0
  ;;
*)
  echo "Unsupported OS: $arch"
  exit 1
  ;;
esac
