# dotfiles

My personal dotfiles.

## 🆕 Creating a new profile

Using this repository as base for a new profile is easy. Just follow these steps:

1. Clone this repository to your local machine
2. Create a new GitHub repository for your profile
3. Make changes (e.g. SSH public key for commit signing) to the files in the repository as needed
4. Push the changes to your new repository
5. To sync with the upstream repository automatically, see [🔄 Sync with Upstream](#-sync-with-upstream) section below.

## ⚙️ GitHub Actions

There are several GitHub Actions workflows defined in this repository to automate various tasks. Below is a brief description of each workflow:

### ✅ CI

This workflow is used to run continuous integration (CI) checks to validate the configuration files and scripts in this repository by installing them in a Linux (Docker), macOS, and Windows environment.

Test job in CI will not run by default. It can be enabled by setting the `CI_PLATFORMS_TO_TEST` variable (e.g. 'linux,macos,windows') in the repository settings.

### 🔄 Sync with Upstream

This workflow is used to sync the current repository with the upstream repository.

It fetches the latest changes from the upstream repository and merges them into the current branch. This is useful for keeping your fork up to date with the original repository.

This workflow is disabled by default and can be enabled by setting the `SYNC_UPSTREAM` variable to the target repository URL in the repository settings.
