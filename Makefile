#!/usr/bin/env -S make -f

MAKEFLAGS += --warn-undefined-variable
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --silent

SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
.DEFAULT_GOAL := help

help: Makefile  ## Show help
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'


# =============================================================================
# Common
# =============================================================================
install:  ## Install deps and tools
	git submodule update --init --recursive
.PHONY: install

init:  ## Initialize project
	pre-commit install --install-hooks
.PHONY: init

update:  ## Update deps and tools
	pre-commit autoupdate
.PHONY: update


# =============================================================================
# CI
# =============================================================================
ci: lint test integration-test nix-check ## Run CI tasks
.PHONY: ci

fmt:  ## Run autoformatters
	pre-commit run --all-files shfmt
.PHONY: fmt

lint:  ## Run all linters
	pre-commit run --all-files shellcheck
.PHONY: lint

test: nix-check nix-build-linux  ## Run tests (linux only for now)

.PHONY: test

nix-check:  ## Validate Nix flake and evaluate profiles
	nix flake check --impure
.PHONY: nix-check

nix-build-linux:  ## Build Linux activation package
	nix build --impure '.#homeConfigurations.linux.activationPackage'
.PHONY: nix-build-linux

nix-build-macos:  ## Build macOS activation package
	nix build --impure '.#homeConfigurations.macos.activationPackage'
.PHONY: nix-build-macos

# =============================================================================
# Handy Scripts
# =============================================================================
# https://stackoverflow.com/questions/66808788/docker-can-you-cache-apt-get-package-installs
docker-sh:  ## Run dotfiles-installed shell in ephemeral Docker container
	docker build --tag dotfiles:local -f- . <<DOCKERFILE
	FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04
	RUN useradd --create-home --shell /bin/bash nonroot
	RUN mkdir --mode=0755 /nix && chown nonroot:nonroot /nix
	USER nonroot:nonroot
	COPY --chown=nonroot:nonroot . /home/nonroot/dotfiles
	WORKDIR /home/nonroot/dotfiles
	DOCKERFILE
	docker run --interactive --tty --rm dotfiles:local
.PHONY: docker-sh

clean:  ## Remove temporary files
	find . -path '*.log*' -delete
.PHONY: clean
