_default:
    just --list

# Install deps and tools
install:

# Update deps and tools
update:
    nix flake update
    pre-commit autoupdate

alias up := update

# =============================================================================
# Development
# =============================================================================

# Run all checks
ci: (format "yes") lint build

# Autoformat code
[arg("check", long="check", value="yes")]
format check="no":
    git ls-files --cached --others --exclude-standard '*.sh' \
        | xargs shfmt {{ if check == "yes" { "--list" } else { "--list --write" } }}
    git ls-files --cached --others --exclude-standard '*.nix' \
        | tee /dev/tty \
        | xargs nixfmt {{ if check == "yes" { "--check" } else { "" } }}

alias fmt := format

# Run all linters
lint:
    git ls-files --cached --others --exclude-standard '*.sh' \
        | tee /dev/tty \
        | xargs shellcheck
    nix flake check --impure
    nix eval --impure '.#default.drvPath'

# Build Nix activation packages
build:
    nix build --impure '.#default'

# Run ephemeral Docker container with dotfiles copy in it for testing
docker-sh:
    cd test/docker && docker compose run --build -it --rm workspace bash

# =============================================================================
# Utility
# =============================================================================

# Remove temporary files
clean:
    find . -path '*.log*' -delete
