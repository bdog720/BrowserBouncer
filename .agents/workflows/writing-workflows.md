---
name: writing-workflows
description: Use when creating new workflows, editing existing workflows, or verifying workflows work before deployment.
---

# Writing Workflows

## Overview

Workflows in `.agents/workflows/` define sequential or parallel steps to accomplish complex tasks using Antigravity.

<HARD-GATE>
**ANTIGRAVITY GUARDRAIL:** You must ONLY generate markdown Artifacts first. NEVER create or modify workflow files in `.agents/workflows/` until explicitly given the 'green light' to proceed. You must first draft the proposed workflow in an `implementation_plan.md` or `research_notes.md` artifact.
</HARD-GATE>

## Workflow Structure

Workflows follow a YAML frontmatter + markdown format:

```markdown
---
description: [short title, e.g. how to deploy the application]
---

# Workflow Details

1. **Step 1:** Describe the step.
2. **Step 2:** Describe the next step.

// turbo
3. **Run Command:** Auto-run this CLI step.
```

## Turbo Annotations

- `// turbo` above a step: Auto-runs the `run_command` for that single step (`SafeToAutoRun: true`).
- `// turbo-all` anywhere in the file: Auto-runs ALL `run_command` steps in the entire workflow.

## Guidelines

1. Focus on explicit, sequential steps.
2. If the workflow requires code modification, explicitly state the Antigravity Guardrail: "Generate an artifact first, get green light, then modify."
3. Request user review of the drafted workflow via `notify_user` before writing to the actual `.agents/workflows/` directory.
