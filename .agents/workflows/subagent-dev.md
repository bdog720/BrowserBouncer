---
description: Use when executing implementation plans with independent tasks in the current session
---

# Subagent-Driven Development

## Overview

Execute a plan by dispatching fresh browser or terminal subagents per task, with two-stage review after each: spec compliance review first, then code quality review.

<HARD-GATE>
**ANTIGRAVITY GUARDRAIL:** You must ONLY generate markdown Artifacts first. NEVER modify application code without explicit user approval. When dispatching subagents, instruct them to report back and aggregate their proposed changes or findings into an intermediate artifact (e.g., `research_notes.md` or `task.md`), rather than altering application code autonomously. Wait for a "green light" via `notify_user` before actually applying the changes to the codebase.
</HARD-GATE>

## The Process

1. **Read plan:** Extract all tasks with full text, note context, and update `task.md`. **Crucially, ensure tasks are sliced into atomized micro-tasks. If a plan contains large steps, break them down before proceeding.**
2. **Dispatch Subagents:** Assign a focused subagent to a **single micro-task** (e.g., via the `browser_subagent` tool or a specialized prompt block). Ensure the subagent prompt provides only the precise context needed for that specific micro-task.
3. **Artifact Aggregation:** The subagent investigates and proposes changes for its specific micro-task in an artifact.
4. **Review:** Perform spec compliance and code quality review on the proposed changes within the artifact.
5. **Request Approval:** Call `notify_user` with `BlockedOnUser: true` for the artifact.
6. **Apply Changes (Code Modification):** ONLY after receiving the green light, implement the changes using code editing tools. Repeat for the next micro-task.

## Red Flags
- Never start implementation on main branch without user consent.
- Never let subagents modify code directly without the intermediate artifact approval state.
