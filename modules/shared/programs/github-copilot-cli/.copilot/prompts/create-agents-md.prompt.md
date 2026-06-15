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

You should include sections for build/test commands, definition of done, guidelines for writing and reviewing code, and instructions for when blocked. Make sure to cover all essential aspects of the development workflow in the `AGENTS.md` file.

## Example

Use the example below as a reference.

```markdown
# Project Instructions

## Build and Test Commands

- Install: `pip install -r requirements.txt`
- Lint: `ruff check . --fix`
- Format: `ruff format .`
- Test: `pytest -v --tb=short`
- Type check: `mypy app/ --strict`
- Full verify: `ruff check . && ruff format --check . && pytest -v`

## Definition of Done

A task is complete when ALL of the following passes:

1. `ruff check .` exits 0
2. `pytest -v` exits 0 with no failures
3. `mypy app/ --strict` exits 0
4. Changed files have been staged and committed
5. Commit message follows: `type(scope): description`

## When Writing Code

- Run `ruff check .` after every file change
- Add type hints to all new functions
- Test command: `pytest tests/ -v -k "test_<module>"`
- Format code once after all tasks are complete: `ruff format .`

## When Reviewing Code

- Check for security issues: `bandit -r app/`
- Verify test coverage: `pytest --cov=app --cov-fail-under=80`

## When Blocked

- If tests fail after 3 attempts: stop and report the failing test with full output
- If a dependency is missing: check `requirements.txt` first, then ask
- Never: delete files to resolve errors, force push, or skip tests
```

Update the file with any project-specific details or commands as needed based on your project's codebase and structure.

## External Resources

For additional context, refer to these external resources

- https://blakecrosley.com/ko/blog/agents-md-patterns
