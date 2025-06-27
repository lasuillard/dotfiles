---
description: This prompt ensures the project adheres to the latest standards and practices, including AI readiness, documentation, and editor configuration.
mode: agent
tools: [codebase, fetch, githubRepo]
---

Assess and suggest improvements to the project based on the following criteria:

## General Guidelines

- Keep things simple and clear.
- Stick with reasonable defaults unless there is a compelling reason to change them. This also applies when adding new files or configurations.
- Ensure the project is easy to understand and maintain.
- Use the provided templates and examples as references.

## Standards and Best Practices

### Project Templates

Refer to the following project templates for structure and best practices:

- https://github.com/lasuillard/my-project-template

## Documentation Level

Ensure the project documentation is rich and precise for both human and AI development workflows.

For small projects, include the following files in the root of the repository:

- **README.md**: Provides an overview of the project, its purpose, and how to get started.
- **CONTRIBUTING.md**: Describes how to contribute to the project and the development workflow.
- **LICENSE** or **LICENSE.md**: Contains the project's license.

For medium to large projects, include the following additional files to enhance documentation:

- **CODE_OF_CONDUCT.md**: Outlines the expected behavior of contributors and maintainers.

## Editor Configuration

The project can include editor-specific configuration files to ensure a consistent development environment for all contributors.

Avoid including personal editor preferences, such as personal extensions or settings, to ensure accessibility for all contributors. Keep the project's editor configuration files clean and focused on the project's requirements.

### VS Code

- Remove personal extensions from `.vscode/extensions.json` and `.devcontainer/devcontainer.json`.
- Remove personal settings from `.vscode/settings.json`.
- Retain settings/extensions related to the project's tech stack, such as language support, linters, formatters, and test explorers.

Assess the entire codebase using the provided instructions.

## Readiness for AI

To work effectively with AI tools, structure and document the project in a way that allows AI to understand its context and functionality. This includes:

### GitHub Copilot

Ensure the following files are present and well-structured:

- Always include a `.github/copilot-instructions.md` file with clear instructions for GitHub Copilot.
- Put project-specific prompts, instructions and chat modes in `.github/{prompts,instructions,chatmodes}/` directories.
