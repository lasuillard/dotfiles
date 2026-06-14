# dotfiles

My personal dotfiles.

This repository contains my personal dotfiles for various tools and applications that I use. These dotfiles are managed using [Nix](https://nixos.org/), [Flakes](https://wiki.nixos.org/wiki/Flakes) and [Home Manager](https://github.com/nix-community/home-manager).

## 🛠️ Installing dotfiles

You can install the Nix (skipped if already installed) and set up dotfiles by running the [install.sh](./scripts/install.sh) script (or [install](./install), which is a symlink to `install.sh`).

### 🐋 Dev Container (Visual Studio Code)

One of the most common use cases is to use dotfiles in VS Code with [Dev Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers). Nix will be installed in the container and Home Manager will be automatically applied.

```json
  "dotfiles.repository": "lasuillard/dotfiles",
  "dotfiles.targetPath": "~/dotfiles",
  "dotfiles.installCommand": "install",
```

### 📋 Manual installation

Check the installation scripts for manual installation on different platforms:

- [install-for-docker.sh](./scripts/install-for-docker.sh) to Install Nix (single-user) and set up dotfiles in a Docker container.
- [install-for-linux.sh](./scripts/install-for-linux.sh) to Install Nix (multi-user) and set up dotfiles on a Linux system.
- [install-for-macos.sh](./scripts/install-for-macos.sh) to Install Nix (multi-user) and set up dotfiles on a macOS system.

### 🔄 Updating dotfiles

You can update dotfiles by running the [update.sh](./scripts/update.sh) script or by running `dotfiles update` ([source](./modules/shared/programs/bash/.bin/shell/dotfiles)), a tiny wrapper around dotfiles management scripts. `dotfiles` is installed when you first install dotfiles.

## ⚙️ Creating a new profile

To create a new profile, you can fork this repository and make changes to the files as needed. You can also create a new repository and use this repository as a template.

Follow the steps below to create a new profile (clone and push to a new repository):

1. Clone this repository to your local machine
2. Create a new GitHub repository for your profile
3. Make changes (e.g. SSH public key for commit signing) to the files in the repository as needed
4. Push the changes to your new repository
5. To sync with the upstream repository automatically, see [🔃 Sync with Upstream](#-sync-with-upstream) section below.

## 🤖 Automation

There are several GitHub Actions workflows defined in this repository to automate various tasks. Below is a brief description of each workflow:

### ✅ CI

This workflow is used to check the validity of dotfiles configuration continuously. It runs on every push and pull request to ensure that the configuration is valid and does not contain any errors.

### 🔃 Sync with Upstream

This workflow is used to sync the current repository with the upstream repository.

It fetches the latest changes from the upstream repository and merges them into the current branch. This is useful for keeping your fork up to date with the original repository.

This workflow is disabled by default and can be enabled by setting the `SYNC_UPSTREAM` variable to the target repository URL in the repository settings.

## 🧑‍💻 Development

See [CONTRIBUTING.md](./CONTRIBUTING.md) file for development instructions.

## 🙏 Special thanks to

References and inspirations for this repository:

- [sudosubin/nixos-config](https://github.com/sudosubin/nixos-config)
