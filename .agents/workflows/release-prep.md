---
description: Prepares release notes for the new app version by parsing docs/release_notes_draft.md and updating the app's release history list.
---

# Release Prep Workflow

## Overview

Run this workflow strictly **before** triggering a release build. It will read the running sheet of unreleased features and update the Flutter UI's `releaseHistory` list.

<HARD-GATE>
**ANTIGRAVITY GUARDRAIL:** You must NEVER autonomously commit code updates for releases without presenting the diffs to the user first. Generate an `implementation_plan.md` or a `walkthrough.md` checking the diff output and get the 'green light' to commit.
</HARD-GATE>

## Procedure

1. **Run the Script:**
// turbo
```bash
python .agents/scripts/generate_release_data.py
```

2. **Verify Diffs:** Check `git diff lib/features/splash/release_notes_data.dart`.
3. **Present Diffs:** Display the diff to the user in a markdown artifact and wait for the green light using `notify_user` with `BlockedOnUser: true`.
4. **Commit:** Once approved, commit the changes to the codebase.
