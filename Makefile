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
	pre-commit install --install-hooks
.PHONY: install

update:  ## Update deps and tools
	pre-commit autoupdate
.PHONY: update


# =============================================================================
# CI
# =============================================================================
ci: lint  ## Run CI tasks
.PHONY: ci

format:  ## Run autoformatters
	pre-commit run --all-files shfmt
.PHONY: format

lint:  ## Run all linters
	pre-commit run --all-files shellcheck
.PHONY: lint

test:  ## Run tests
	docker run --rm \
		--volume .:/workspace \
		--workdir /workspace \
		--user "$(shell id -u):$(shell id -g)" \
		mcr.microsoft.com/devcontainers/base:1-ubuntu-22.04 \
		/workspace/scripts/test.sh
.PHONY: test


# =============================================================================
# Handy Scripts
# =============================================================================
clean:  ## Remove temporary files
	find . -path '*.log*' -delete
.PHONY: clean
