# 👥 Development guide

This project is for personal use and not open for public contributions. Here, I describe how to develop and maintain this project.

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

Quick comparison of Nix packages, programs and services:

| Type         | Description                                                                         |
| ------------ | ----------------------------------------------------------------------------------- |
| **Packages** | Software packages to be installed on the system (e.g. `git`, `curl`, `vim`)         |
| **Programs** | User-level configurations for specific programs (e.g. Git, Tailscale)               |
| **Services** | System-level services that run in the background (e.g. SSH agent, Tailscale daemon) |

## 🔧 Set up development environment

For development, you need to have the following tools installed:

### ❄️ Tools managed via Nix Flakes

This repository uses [Nix Flakes](https://nix.dev/concepts/flakes.html) to manage tools. Following tools will be automatically installed (you need `nix` installed, of course):

- `git`
- `pre-commit`
- [Just](https://just.systems/) (`just`)
- `nixfmt`
- `shellcheck`
- `shfmt`

We have configuration ([devcontainer.json](./.devcontainer.example/devcontainer.json)) for it, with Nix and Docker (DinD) installed. All you need to do is to run `nix develop` to start the development environment then run `just install` to install dependencies.

## ⌨️ Adding, modifying, and deleting programs

Changing what programs are installed is quite simple and straightforward. You would need to update following files:

- `modules/linux/home.nix` for Linux-specific configurations
- `modules/macos/home.nix` for macOS-specific configurations
- `modules/shared/programs/` for new program configurations
- `modules/shared/packages.nix` for common packages for all platforms

However, describing advanced usage with Nix here is quite beyond the scope of this document. You can refer to the official documentation for more information:

- [Nix](https://nix.dev/)
- [NixOS Search](https://search.nixos.org/packages)
- [Flake](https://nix.dev/concepts/flakes.html)
- [Home Manager](https://nix-community.github.io/home-manager/)

## ✅ Verifying changes

Before you push your code, you need to verify your code changes if it follows with the project's coding standard. You can run `just ci` to run all the necessary linters, formatters. Resource-heavy tests (including build) will run on CI environment.

## 🚀 Publishing changes

Dotfiles does not require you to publish changes to any other than GitHub. Once code is pushed to the main branch, you can run `dotfiles update` to update your dotfiles.
