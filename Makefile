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
	git submodule update --init --recursive --remote
	pre-commit install --install-hooks
.PHONY: install

update:  ## Update deps and tools
	pre-commit autoupdate
.PHONY: update


# =============================================================================
# CI
# =============================================================================
ci: lint test integration-test  ## Run CI tasks
.PHONY: ci

format:  ## Run autoformatters
	pre-commit run --all-files shfmt
.PHONY: format

lint:  ## Run all linters
	pre-commit run --all-files shellcheck
.PHONY: lint

test:  ## Run tests
	./test/bats/bin/bats --verbose-run ./test/unit
.PHONY: test

integration-test:
	if [ "$$(uname --kernel-name)" != "Linux" ]; then
		echo "In local environment, skip integration tests on non-Linux platform";
		exit 0;
	fi
	./test/bats/bin/bats --verbose-run ./test/integration/linux
.PHONY: integration-test

# =============================================================================
# Handy Scripts
# =============================================================================
clean:  ## Remove temporary files
	find . -path '*.log*' -delete
.PHONY: clean
