---
description: Common Python coding style and practices.
applyTo: '**/*.py'
---

## About

This document provides general instructions for writing Python code.

## Instructions

- Always type hint function parameters and return types.
- Omit type hints in docstring if function already has type hints in the signature.

## Best Practices

- Prefer tuple over list when generating `__all__`. It should be immutable.
