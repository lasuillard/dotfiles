# dotfiles

My personal dotfiles.

## 🆕 Creating a new profile

Using this repository as base for a new profile is easy. Just follow these steps:

1. Clone this repository to your local machine
1. Create a new GitHub repository for your profile
1. Make changes (e.g. SSH public key for commit signing) to the files in the repository as needed
1. Push the changes to your new repository
1. To sync with the upstream repository automatically, see [🔄 Sync with Upstream](#-sync-with-upstream) section below.

## 🛠️ Installing dotfiles

This project is managed using [Nix](https://nixos.org/) and [Home Manager](https://github.com/nix-community/home-manager).

### Visual Studio Code (Dev Containers)

Recommended usage is to use [Dev Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers). Home Manager will be automatically applied if Nix is available in the container.

```json
  "dotfiles.installCommand": "install-for-docker.sh",
  "dotfiles.repository": "lasuillard/dotfiles",
  "dotfiles.targetPath": "~/dotfiles",
```

### Manual Installation

> [!IMPORTANT]
> A migration to Nix is in progress. See [Migration Guide](docs/MIGRATION.md) for details.

1.  **Install Nix**:
    ```bash
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    ```
2.  **Apply configuration**:

    **Linux**:
    ```bash
    nix run home-manager/release-24.05 -- switch --flake .#linux-$(whoami)
    ```

    **macOS**:
    ```bash
    nix run home-manager/release-24.05 -- switch --flake .#macos-$(whoami)
    ```

## ⚙️ Workflows

There are several GitHub Actions workflows defined in this repository to automate various tasks. Below is a brief description of each workflow:

### ✅ CI

This workflow is used to run continuous integration (CI) checks to validate the configuration files and scripts in this repository by installing them in a Linux (Docker), macOS, and Windows environment.

Test job in CI will not run by default. It can be enabled by setting the `CI_PLATFORMS_TO_TEST` variable (e.g. 'linux,macos,windows') in the repository settings.

### 🔄 Sync with Upstream

This workflow is used to sync the current repository with the upstream repository.

It fetches the latest changes from the upstream repository and merges them into the current branch. This is useful for keeping your fork up to date with the original repository.

This workflow is disabled by default and can be enabled by setting the `SYNC_UPSTREAM` variable to the target repository URL in the repository settings.
