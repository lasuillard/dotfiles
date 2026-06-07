---
description: Common GitHub Actions practices.
applyTo: '.github/workflows/*.{yaml,yml}'
---

## Instructions

- Use least privilege: grant only the permissions each job needs.
- Name workflows, jobs, and steps clearly so their purpose is obvious.
- Keep workflows DRY by reusing actions, composite actions, or reusable workflows.
- Store secrets in environment variables and avoid hardcoding sensitive values.
- Add error handling and notifications to catch and surface failures quickly.
- Pin actions to patch-level versions or commit hashes for stability.
- Set `timeout-minutes` on jobs to prevent runaway workflows.
