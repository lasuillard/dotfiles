---
description: Common documentation guidelines.
applyTo: '**/*.{md,rst}'
---

## Instructions

- Prefer **Title Case** for top-level headers.
- Use **Sentence case** for section headers.
- Use code block for commands, paths (including file names) and URLs.
- Use Utility Argument Syntax for CLI usage examples: https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html
  - Prefer this style in examples:
    - `command [options] <arg>`
    - `command --flag <file> [--level NUM]`
    - `tool subcommand [--verbose] <input> [output]`
  - Use uppercase for metavariables and lowercase for literal syntax:
    - `command <FILE>`: `FILE` is a placeholder
    - `command --help`: `--help` is literal text
