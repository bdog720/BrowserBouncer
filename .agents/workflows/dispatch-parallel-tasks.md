---
description: Use when facing 2+ independent tasks that can be worked on without shared state or sequential dependencies
---

# Dispatch Parallel Tasks

## Overview

Execute multiple independent tasks simultaneously by leveraging Antigravity's concurrent tool calls (e.g., executing multiple terminal commands or API requests in parallel).

<HARD-GATE>
**ANTIGRAVITY GUARDRAIL:** You must ONLY generate markdown Artifacts first. NEVER modify application code via parallel tool calls. Any parallel findings, research, or proposed edits MUST be aggregated into an artifact (like `research_notes.md`). You must await the user's explicit "green light" before applying code changes based on parallel operations.
</HARD-GATE>

## Guidelines

1. **Identify Independent Tasks:** Ensure tasks share no state or sequential dependency (e.g., fetching data from two different APIs, parsing two different documentation files).
2. **Batch the Calls:** Issue the necessary tool calls concurrently without the `waitForPreviousTools: true` flag in the earlier calls.
3. **Aggregate:** Collect the parallel results into a single consolidated artifact.
4. **Propose Plan:** Formulate the insights into an `implementation_plan.md` and present it to the user.
