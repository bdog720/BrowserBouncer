---
name: writing-plans
description: Use when you have a spec or requirements for a multi-step task, before touching code
---

# Writing Plans

## Overview

Write comprehensive implementation plans using the `implementation_plan.md` artifact format. Document everything the execution phase needs to know: which files to touch for each task, code, testing, docs they might need to check, and how to test it.

<HARD-GATE>
**ANTIGRAVITY GUARDRAIL:** You must ONLY generate the `implementation_plan.md` artifact first. NEVER modify application code until explicitly given the 'green light' to proceed by requesting review of the artifact via the `notify_user` tool.
</HARD-GATE>

## Granularity

**CRITICAL: Tasks must be atomized into micro-tasks.** Lighter-weight AI agents (like Gemini 1.5 Flash) struggle with large, multi-file edits. Break work down into the absolute smallest manageable pieces.

Each step must be a single, strict action (e.g., modifying one specific function, adding a single import, or creating a basic skeleton):
- "Add import statements to `file1.dart`"
- "Update the `build` method in `file2.dart` to use `NewWidget`"
- "Run `flutter test` for `feature_x_test.dart` and verify"

Do NOT write generic steps like "Implement feature X."

## Plan Structure (`implementation_plan.md`)

Use the standard artifact format, but ensure you include a **Step-by-step Task Breakdown**:

```markdown
# [Feature Name] Implementation Plan

## Proposed Changes
### Component Name
#### [MODIFY] path/to/file.ext
- **Micro-task 1:** Description of the smallest isolated change here.
- **Micro-task 2:** Description of the next isolated change.
#### [NEW] path/to/new_file.ext
- **Micro-task 3:** Create the file with the skeleton structure.
- **Micro-task 4:** Implement specific method `Y`.

## Verification Plan
### Automated Tests
Exact commands to run

### Manual Verification
Steps to verify manually
```

## Execution Handoff

After writing the `implementation_plan.md` artifact:
1. Call `notify_user` with `BlockedOnUser: true` and the path to the artifact in `PathsToReview`.
2. Wait for the user to give the "green light".
3. Only then may you enter EXECUTION mode to implement the plan.
