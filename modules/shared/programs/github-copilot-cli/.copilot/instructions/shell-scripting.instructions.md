---
description: Shell scripting guidelines
applyTo: '**/*.{sh,bash}'
---

## Instructions

- Add a shebang (`#!`) at the top of scripts.
- Fail fast with `set -o errexit nounset pipefail`.
- Use `trap` for cleanup and signal handling.
- Prefer long options (e.g. `--recursive` over `-r`) when available.
- Use single quotes unless interpolation is required.
- Quote variables: `"$VAR"`, and use `"${VAR}"` for embedded references.
