---
description: Use when encountering any bug, test failure, or unexpected behavior, before proposing fixes
---

# Systematic Debugging

## Overview

Rigorous, step-by-step bug isolation and resolution. Follow the scientific method: observe, hypothesize, test, fix.

<HARD-GATE>
**ANTIGRAVITY GUARDRAIL:** You must ONLY generate markdown Artifacts first. Root cause analysis (RCA) and proposed fixes MUST be written to an `implementation_plan.md` (or similar text artifact). NEVER modify application code to attempt a fix until the user gives the "green light" to proceed.
</HARD-GATE>

## Triage Checklist

Use these in order:

1. **Reproduce:** Obtain a reliable test or script that fails.
2. **Localize:** Determine which layer is failing (UI, API, DB, network, build tooling).
3. **Reduce:** Minimal failing case (smaller input, fewer steps).
4. **Propose Fix (Artifact):** Draft the proposed fix in an `implementation_plan.md` and request user review via `notify_user`.
5. **Fix Root Cause:** Once approved, make the code change.
6. **Guard:** Add regression coverage (test or invariant check).
7. **Verify:** Confirm the original failure no longer occurs, and write findings to `walkthrough.md`.
