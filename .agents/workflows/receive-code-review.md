---
description: Use when receiving code review feedback, before implementing suggestions, especially if feedback seems unclear or technically questionable 
---

# Receive Code Review

## Overview

Process code review feedback intelligently before executing adjustments. Address PR/review feedback systematically.

<HARD-GATE>
**ANTIGRAVITY GUARDRAIL:** You must ONLY generate markdown Artifacts first. When given feedback, parse the feedback into an `implementation_plan.md` artifact proposing a fix. NEVER modify application code unprompted to satisfy feedback until the user grants explicit "green light".
</HARD-GATE>

## Procedure

1. **Parse Feedback:** Read the reviewer's feedback. If unclear, ask clarifying questions using `notify_user`. Do this before taking any action.
2. **Draft Updates:** Compile the agreed-upon resolutions into an updated `implementation_plan.md` artifact.
3. **User Confirmation:** If the reviewer is not the main user, have the main user approve the updated plan via `notify_user` (`BlockedOnUser: true`).
4. **Execution Mode:** Switch to `EXECUTION` mode to safely apply fixes inline with the new plan.
5. **Validation:** Re-run verification and update `walkthrough.md` outlining the fixed feedback points.
