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

# Ensure core.fsmonitor is disabled to avoid issues with Nix: error: file '/fsmonitor--daemon.ipc' has an unsupported type
echo "Disabling Git core.fsmonitor for Dotfiles repository to avoid issues with Nix"
git config --local core.fsmonitor false
rm -f "${project_root}/.git/fsmonitor--daemon.ipc"

# Function to check if we're running in a Docker container by evaluating common indicators
is_docker() {
  if [ -f /proc/1/cgroup ] && grep -q docker /proc/1/cgroup; then
    echo "true"
    return
  fi
  if [ -f "/.dockerenv" ]; then
    echo "true"
    return
  fi
  echo "false"
}

# Global Nix configuration and arguments default
if [ -z "${NIX_CONFIG:-}" ]; then
  NIX_CONFIG="$(
    cat <<'EOF'
extra-experimental-features = nix-command flakes
EOF
  )"
  export NIX_CONFIG
fi

# Custom environment variable for passing additional arguments to Nix commands
if [ -z "${NIX_ARGS:-}" ]; then
  # Always follow latest input for specific Nix inputs
  export NIX_ARGS="\
    --override-input my-agents git+ssh://git@github.com/lasuillard/agents?ref=main \
    --override-input my-secrets git+ssh://git@github.com/lasuillard/secrets?ref=main \
  "
fi

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
  ;;
Darwin*)
  echo "Detected macOS, running macOS-specific installation script"
  sh "${project_root}/scripts/install-for-macos.sh"
  ;;
*)
  echo "Unsupported OS: $arch"
  exit 1
  ;;
esac

# Verify that nix is installed and available in the PATH
nix --version

# Activate the user profile with home-manager
echo
# shellcheck disable=SC2086
result="$(
  nix build \
    --impure \
    --no-link \
    --print-out-paths \
    $NIX_ARGS \
    'path:.#default'
)"

HOME_MANAGER_BACKUP_EXT=backup "$result"/activate

echo "Dotfiles installation completed successfully."
