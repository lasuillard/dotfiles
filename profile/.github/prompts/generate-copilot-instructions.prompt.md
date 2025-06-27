---
description: Generate `.github/copilot-instructions.md` for this codebase.
mode: agent
tools: ['codebase', 'editFiles', 'fetch', 'githubRepo']
---

Generate a `.github/copilot-instructions.md` file for this codebase.

## Requirements:

1. Add front matter with a `description` field.
2. Briefly state the project's purpose.
3. Omit any heading like `# GitHub Copilot Instructions`.
4. List the tech stack and core dependencies with major versions, with its usage context.
5. Describe the project structure and key directories.
6. Give concise development guidelines (coding standards, patterns, best practices).

## Guardrails:

- Keep it simple and under 30 lines.
- Use clear, high-level language.
- Ensure relevance to the current codebase.
