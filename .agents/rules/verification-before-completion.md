---
name: verification-before-completion
description: Use when about to claim work is complete, fixed, or passing, before committing or creating PRs
---

# Verification Before Completion

## Overview

A rigid rule that execution of verification commands (tests, linting, builds) must be performed and documented before claiming a task is done.

<HARD-GATE>
**ANTIGRAVITY GUARDRAIL:** You must ONLY generate an artifact as proof. Evidence before assertions always. NEVER claim a fix is implemented, tests pass, or zero warnings exist without explicitly logging the terminal output of those checks to `walkthrough.md` or `task.md`.
</HARD-GATE>

## Check Sequence

1. **Lint/Format:** Run local static checks (e.g., `flutter analyze` or pre-commit hooks). Ensure clean output.
2. **Unit Tests:** Execute `flutter test` or equivalent backend tests for any modified logic. Ensure passing.
3. **Build:** Run a build dry-run if the change affects compilation (e.g., `flutter build`).
4. **Proof of Pass:** Log the test output, coverage changes, or CLI checks as markdown into your current task or walkthrough before requesting review.

## Warning
- Stating "I have verified it works" without running command-line verification and presenting evidence is an unacceptable violation of this protocol.
