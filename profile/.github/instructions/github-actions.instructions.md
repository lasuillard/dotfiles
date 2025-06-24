---
description: Common GitHub Actions practices.
applyTo: '.github/workflows/*.{yaml,yml}'
---

## About

This document provides general instructions for writing GitHub Actions workflows.

## Instructions

- Least privilege principle: Use the least amount of permissions necessary for the job.
- Use descriptive names for your workflows, jobs, and steps to make their purpose clear.
- Keep your workflows DRY (Don't Repeat Yourself) by using reusable components like actions and composite actions.
- Use environment variables to store sensitive information and avoid hardcoding secrets in your workflows.
- Include error handling and notifications in your workflows to catch failures early and inform the right people.
- Pin workflow actions to specific patch-level versions, or commit hashes to ensure stability and avoid unexpected changes.
- Always specify `timeout-minutes` for jobs to prevent them from running indefinitely.
