# 👥 Development guide

This project is for personal use and is not open for public contributions. This document describes how to develop and maintain it.

## 🛠️ Tech stack

This project uses the following tech stack:

- [Bash](https://www.gnu.org/software/bash/)
- [Nix](https://nixos.org/)

## 📂 Key directory structure

- `.devcontainer.example/`: Development environment configuration
- `.vscode.example/`: Project-specific VS Code configuration example
- `lib/`:
  - `home-manager/`
    - `programs/`
    - `services/`
- `modules/`
  - `linux/`: Linux-specific configurations
    - `programs/`
    - `services/`
  - `macos/`: macOS-specific configurations
    - `programs/`
    - `services/`
  - `shared/`: Configurations for all platforms
    - `programs/`
    - `services/`
    - `packages.nix`: Packages to be installed for all platforms
- `scripts/`: Scripts for dotfiles management
- `flake.nix` and `flake.lock`: Nix flake configuration files for installation and development of dotfiles
- `install`: Script to install dotfiles, symlinked to `scripts/install.sh`
- `Justfile`: Commands for development

Quick comparison of Nix packages, programs, and services:

| Type         | Description                                                                         |
| ------------ | ----------------------------------------------------------------------------------- |
| **Packages** | Software packages to be installed on the system (e.g. `git`, `curl`, `vim`)         |
| **Programs** | User-level configurations for specific programs (e.g. Git, Tailscale)               |
| **Services** | System-level services that run in the background (e.g. SSH agent, Tailscale daemon) |

## 🔧 Set up development environment

For development, you need to have the following tools installed:

### ❄️ Tools managed via Nix Flakes

This repository uses [Nix Flakes](https://nix.dev/concepts/flakes.html) to manage tools. The following tools are installed automatically (you need `nix` installed, of course):

- `git`
- `pre-commit`
- [Just](https://just.systems/) (`just`)
- `nixfmt`
- `shellcheck`
- `shfmt`

Run `nix develop` to start the development environment, then run `just install` to install dependencies.

There is also a configuration file ([devcontainer.json](./.devcontainer.example/devcontainer.json)) for it, with Nix and Docker (DinD) installed.

## ⌨️ Adding, modifying, and deleting programs

Changing installed programs is straightforward. You need to update the following files:

- `modules/linux/home.nix` for Linux-specific configurations
- `modules/macos/home.nix` for macOS-specific configurations
- `modules/shared/programs/` for new program configurations
- `modules/shared/packages.nix` for common packages for all platforms

However, describing advanced usage with Nix here is beyond the scope of this document. You can refer to the official documentation for more information:

- [Nix](https://nix.dev/)
- [NixOS Search](https://search.nixos.org/packages)
- [Flake](https://nix.dev/concepts/flakes.html)
- [Home Manager](https://nix-community.github.io/home-manager/)

## ✅ Verifying changes

Before pushing code, verify your changes follow the project's coding standards. You can run `just ci` to run all necessary linters and formatters. Resource-heavy tests (including builds) run in the CI environment.

## 🚀 Publishing changes

Dotfiles does not require you to publish changes anywhere other than GitHub. Once code is pushed to the `main` branch, you can run `dotfiles update` to update your dotfiles.
