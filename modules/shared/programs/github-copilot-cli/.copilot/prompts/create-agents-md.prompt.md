---
name: Create AGENTS.md
description: Create or update an AGENTS.md file for project-scoped AI instructions.
agent: agent
tools:
    [
        agent/runSubagent,
        read,
        search,
        web
    ]
---

Create a new `AGENTS.md` file for a project to provide instructions for AI coding agents.

## Instructions

1. Read project documentation files such as `README.md`, `CONTRIBUTING.md`, `docs/` to understand the project.
1. If you do need additional context, scan for codebase.
1. Write `AGENTS.md` file with the following sections:

    - Build and test commands
    - Definition of done
    - When writing code
    - When reviewing code
    - When blocked

Refer to the below example to see how the `AGENTS.md` file should look like.

## Example

Use the example below as a reference.

```markdown
# AGENTS.md

## Build and test commands

- Install: `pip install -r requirements.txt`
- Lint: `ruff check . --fix`
- Format: `ruff format .`
- Test: `pytest -v --tb=short`
- Type check: `mypy app/ --strict`
- Full verify: `ruff check . && ruff format --check . && pytest -v`

## Definition of done

A task is complete when ALL of the following passes:

1. `ruff check .` exits 0
2. `pytest -v` exits 0 with no failures
3. `mypy app/ --strict` exits 0
4. Changed files have been staged and committed
5. Commit message follows: `type(scope): description`

## When writing code

- Run `ruff check .` after every file change
- Add type hints to all new functions
- Test command: `pytest tests/ -v -k "test_<module>"`
- Format code once after all tasks are complete: `ruff format .`

## When reviewing code

- Check for security issues: `bandit -r app/`
- Verify test coverage: `pytest --cov=app --cov-fail-under=80`

## When blocked

- If tests fail after 3 attempts: stop and report the failing test with full output
- If a dependency is missing: check `requirements.txt` first, then ask
- Never: delete files to resolve errors, force push, or skip tests
```

Update the file with any project-specific details or commands as needed based on your project's codebase and structure.

## External Resources

For additional context, refer to these external resources

- https://blakecrosley.com/ko/blog/agents-md-patterns
