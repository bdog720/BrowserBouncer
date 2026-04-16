---
description: Use when starting feature work that needs isolation from current workspace or before executing implementation plans 
---

# Use Git Worktrees

## Overview

Manage isolated Git worktrees for safe, parallel feature development without disrupting your primary `main` or active branch context.

<HARD-GATE>
**ANTIGRAVITY GUARDRAIL:** You must NEVER create directories, check out branches, or run Git worktree commands to modify the environment autonomously unless you explicitly write the `git worktree add` statements into an implementation plan artifact or `research_notes.md` first, AND the user explicitly gives you the "green light".
</HARD-GATE>

## Procedure

1. **Plan Isolation:** Determine the target branch name and path (e.g., `../pumpwatch-feature-xyz`).
2. **Draft Commands:** Write the workflow steps into an artifact:
   - Example draft step: `git worktree add ../pumpwatch-feature-xyz feature-xyz`
3. **Request Review:** Present the artifact to the user via `notify_user`.
4. **Execute:** Run the commands ONLY when approved.

## Best Practices
- Keep worktrees outside the main repo directory if possible (e.g., alongside the project root) to avoid polluting IDE search paths or causing indexing loops.
