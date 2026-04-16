---
name: brainstorming
description: "You MUST use this rule before any creative work - creating features, building components, adding functionality, or modifying behavior. Explores user intent, requirements and design before implementation."
---

# Brainstorming Ideas Into Designs

## Overview

Help turn ideas into fully formed designs and specs through natural collaborative dialogue.

Start by understanding the current project context, then ask questions one at a time to refine the idea. Once you understand what you're building, present the design and get user approval via `notify_user`.

<HARD-GATE>
**ANTIGRAVITY GUARDRAIL:** You must ONLY generate markdown Artifacts first. NEVER modify application code until explicitly given the 'green light' to proceed. The result of this brainstorming rule MUST be the creation of an `implementation_plan.md` artifact.
</HARD-GATE>

## Anti-Pattern: "This Is Too Simple To Need A Design"

Every project goes through this process. A todo list, a single-function utility, a config change — all of them. "Simple" projects are where unexamined assumptions cause the most wasted work. The design can be short (a few sentences for truly simple projects), but you MUST present it and get approval.

## Checklist

You MUST complete them in order:

1. **Explore project context** — check files, docs, recent commits
2. **Ask clarifying questions** — one at a time, understand purpose/constraints/success criteria. Use `notify_user` to ask.
3. **Propose 2-3 approaches** — with trade-offs and your recommendation.
4. **Present design** — Write an `implementation_plan.md` artifact, and request review using `notify_user` with `BlockedOnUser: true`.
5. **Transition to implementation** — Once approved, switch to EXECUTION mode to begin the plan.

## Principles

- **One question at a time** - Don't overwhelm with multiple questions via `notify_user`.
- **Incremental validation** - Present design via artifact, get "green light" before touching code.
