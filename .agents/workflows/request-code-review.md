---
description: Use when completing tasks, implementing major features, or before merging to verify work meets requirements
---

# Requesting Code Review

## Overview

A guide on structuring and packaging your work for peer code review or user approval. Follow this workflow before declaring tasks complete.

<HARD-GATE>
**ANTIGRAVITY GUARDRAIL:** You must ONLY generate markdown Artifacts first. The agent MUST NOT autonomously assert that a feature is complete and ready to merge until the user has reviewed the generated `walkthrough.md` and explicitly given the "green light".
</HARD-GATE>

## Pre-Review Checklist

1. **Verify Completion:** Run all tests and linters. Run `verification-before-completion` rule logic.
2. **Review Self-Code:** Read your own diff. Ensure there are no debugging statements left.
3. **Compile `walkthrough.md`:** 
   - State what changed.
   - Embed screenshots if applicable (always absolute paths).
   - Use `render_diffs(file:///path)` to display diffs where useful.
4. **Notify User:** Request review via `notify_user` with `BlockedOnUser: true` for the walkthrough.

## During Review
- Explain **why** decisions were made, not just **what** changed.
- If proposing architectural shifts, tie them explicitly to `docs/product_requirements.md`.
