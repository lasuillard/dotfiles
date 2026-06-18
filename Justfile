_default:
    just --list

# Install deps and tools
install:

# Update deps and tools
update:
    pre-commit autoupdate

alias up := update

# =============================================================================
# Development
# =============================================================================

# Run all checks
ci: lint

# Autoformat code
format:
    shfmt --write --list .
    git ls-files --cached --others --exclude-standard '*.nix' | xargs nixfmt

alias fmt := format

# Run all linters
lint:
    git ls-files --cached --others --exclude-standard '*.sh' | xargs shellcheck

# Build Linux activation packages
nix-build-linux:
    nix build --impure '.#homeConfigurations.linux.activationPackage'

# Build macOS activation packages
nix-build-macos:
    nix build --impure '.#homeConfigurations.macos.activationPackage'

# Run ephemeral Docker container with dotfiles copy in it for testing
docker-sh:
    cd test/docker && docker compose run --build -it --rm workspace bash

# =============================================================================
# Utility
# =============================================================================

# Remove temporary files
clean:
    find . -path '*.log*' -delete
