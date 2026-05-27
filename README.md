# dotfiles

My personal dotfiles.

This repository contains my personal dotfiles for various tools and applications that I use. These dotfiles are managed using [Nix](https://nixos.org/), [Flakes](https://wiki.nixos.org/wiki/Flakes) and [Home Manager](https://github.com/nix-community/home-manager).

## 🛠️ Installing dotfiles

You can install the Nix (skipped if already installed) and set up dotfiles by running the [install.sh](./install.sh) script.

### 🐋 Dev Containers (Visual Studio Code)

Recommended usage is to use [Dev Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers). Home Manager will be automatically applied if Nix is available in the container.

```json
  "dotfiles.repository": "lasuillard/dotfiles",
  "dotfiles.targetPath": "~/dotfiles",
  "dotfiles.installCommand": "install-for-docker.sh",
```

### 📋 Manual Installation

Check the installation scripts for manual installation on different platforms:

- [install-for-docker.sh](./install-for-docker.sh) to Install Nix (single-user) and set up dotfiles in a Docker container.
- [install-for-linux.sh](./install-for-linux.sh) to Install Nix (multi-user) and set up dotfiles on a Linux system.
- [install-for-macos.sh](./install-for-macos.sh) to Install Nix (multi-user) and set up dotfiles on a macOS system.

## 🪾 Key directory structure

Code structure of the repository is organized as follows:

> [!NOTE]
> **shell.nix** file is not relevant to the dotfiles configuration and is used for development purposes only.

- **lib/**:
  - **home-manager/**
    - **programs/**
    - **services/**
- **modules/**
  - **linux/**: Linux-specific configurations
    - **programs/**
    - **services/**
  - **macos/**: macOS-specific configurations
    - **programs/**
    - **services/**
  - **shared/**: Configurations for all platforms
    - **programs/**
    - **services/**
    - **packages.nix**: Packages to be installed for all platforms
- **flake.nix** and **flake.lock**: Nix flake configuration files

Quick comparison of Nix packages, programs and services:

| Type         | Description                                                                         |
| ------------ | ----------------------------------------------------------------------------------- |
| **Packages** | Software packages to be installed on the system (e.g. `git`, `curl`, `vim`)         |
| **Programs** | User-level configurations for specific programs (e.g. Git, Tailscale)               |
| **Services** | System-level services that run in the background (e.g. SSH agent, Tailscale daemon) |

## 🆕 Creating a new profile

To create a new profile, you can fork this repository and make changes to the files as needed. You can also create a new repository and use this repository as a template.

Follow the steps below to create a new profile (clone and push to a new repository):

1. Clone this repository to your local machine
2. Create a new GitHub repository for your profile
3. Make changes (e.g. SSH public key for commit signing) to the files in the repository as needed
4. Push the changes to your new repository
5. To sync with the upstream repository automatically, see [🔄 Sync with Upstream](#-sync-with-upstream) section below.

## ⚙️ Workflows

There are several GitHub Actions workflows defined in this repository to automate various tasks. Below is a brief description of each workflow:

### ✅ CI

This workflow is used to check the validity of dotfiles configuration continuously. It runs on every push and pull request to ensure that the configuration is valid and does not contain any errors.

### 🔄 Sync with Upstream

This workflow is used to sync the current repository with the upstream repository.

It fetches the latest changes from the upstream repository and merges them into the current branch. This is useful for keeping your fork up to date with the original repository.

This workflow is disabled by default and can be enabled by setting the `SYNC_UPSTREAM` variable to the target repository URL in the repository settings.

## 🙏 Special thanks to

References and inspirations for this repository:

- [sudosubin/nixos-config](https://github.com/sudosubin/nixos-config)
