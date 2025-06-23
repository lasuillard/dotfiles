---
description: General shell scripting instructions for AI.
applyTo: '**/*.{sh,bash}'
---

## About

This document provides general instructions for writing shell scripts.

## Instructions

- Use shebang (`#!/bin/bash` or `#!/usr/bin/env bash`) at the top of your scripts to specify the interpreter.
- Use `set -o` to enable these options:
    ```bash
    set -o errexit  # Exit on error
    set -o nounset  # Treat unset variables as an error
    set -o pipefail # Return the exit status of the last command in the pipeline that failed
    ```
- Use `trap` to handle signals and cleanup tasks.

## Best Practices

- Use single quotes (`'`) for strings unless you need variable interpolation or command substitution.
- Prefer long option names over short ones for better readability, unless long options are not available.
- When directly using the value of variable, use `"$VAR"` instead of `$VAR` to prevent word splitting and globbing.
- When using variables in string interpolation, use `"${VAR}"` instead of `"$VAR"` to clearly define variable boundaries.
