---
description: Use when implementing any feature or bugfix, before writing implementation code
---

# Test-Driven Development (TDD)

## Overview

Follow the rigorous RED-GREEN-REFACTOR cycle for all feature development and bug fixes. No code is written without a failing test first.

<HARD-GATE>
**ANTIGRAVITY GUARDRAIL:** You must ONLY generate markdown Artifacts first. The test concept and required structural additions must be outlined in an `implementation_plan.md` artifact. NEVER modify or create test/application code until explicitly given the 'green light'.
</HARD-GATE>

## Cycle

1. **RED (Write failing test concept):** Propose the exact test in the implementation plan. Get user approval. Once approved, write the test code and run it. Verify it fails for the expected reason.
2. **GREEN (Minimal code):** Write the absolute minimum code to make the test pass.
3. **REFACTOR:** Clean up the implementation. Run tests again.
4. **DOCUMENT:** Ensure any structural changes are documented per `.agents/rules/document-as-you-go.md`. Update Riverpod DartDoc, Edge Function JSDoc, or architecture/flow Markdown diagrams as needed.
