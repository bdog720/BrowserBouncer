---
description: Use when implementation is complete, all tests pass, and you need to decide how to integrate the work
---

# Finish Development Branch

## Overview

Guide the completion of development work by presenting structured options for merge, PR, or cleanup, and generating required verification artifacts.

<HARD-GATE>
**ANTIGRAVITY GUARDRAIL:** You must ONLY generate markdown Artifacts first. The agent MUST NOT autonomously `git push`, create PRs using CLI tools, or merge branches. Instead, it MUST create a `walkthrough.md` documenting what changed, the testing strategy, and the verification results, and wait for the user's "green light" to invoke integration commands.
</HARD-GATE>

## The Process

1. **Compile Proof of Work:** Generate or update `walkthrough.md`.
   - Use `render_diffs(file:///absolute/path/to/file)` to show changes.
   - Describe what was tested and how (screenshots of UI changes if possible).
2. **Present Final Artifacts:** Ensure all tests pass and linters are green.
3. **Notify User:** Request review on the `walkthrough.md` via `notify_user` with `BlockedOnUser: true`.
4. **Execute Handoff:**
   - Wait for explicit user confirmation.
   - If user says "Merge", then run the merge commands safely.
   - If user says "Create PR", draft the CLI command and ask.
