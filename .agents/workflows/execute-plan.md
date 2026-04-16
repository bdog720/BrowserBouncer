---
description: Use when you have a written implementation plan to execute. 
---

# Execute Plan

## Overview

Process an `implementation_plan.md` artifact step-by-step.

<HARD-GATE>
**ANTIGRAVITY GUARDRAIL:** You must NEVER modify application code until you have received explicitly the "green light" to proceed on the `implementation_plan.md` from the user via `notify_user`.
</HARD-GATE>

## Process

1. **Review Plan:** Ensure the user has approved the `implementation_plan.md`. If they haven't, halt and call `notify_user` to request review. Ensure the plan is broken down into atomized **micro-tasks**. If it is not, return to PLANNING mode and rewrite it.
2. **Execute Micro-Tasks:** Follow the plan, tackling **strictly one micro-task per iteration**. Do not attempt to batch multiple files or large logical changes into a single tool call—lighter-weight models *will* fail context. 
3. **Verification:** For each micro-task independently, verify the code compiles/tests pass. Write the verification outcomes to `walkthrough.md`.
4. **Commits:** Make frequent commits (using `// turbo-all` for local scripts if appropriate, though use judgment with `run_command`).
