---
description: Rule enforcing the "Supercharged" documentation standards for junior developers
---

# Documentation Supercharge Standards

All documentation in the `docs/` directory must adhere to the following standards to ensure accessibility for junior developers.

## 1. Internal Context (Roamlinks)
- **Requirement:** Any reference to a custom Class, Function, File, or variable MUST be wrapped in Obsidian-style roamlinks.
- **Syntax:** `[[ClassName#functionName]]` or `[[FileName]]`.
- **Purpose:** To allow developers to navigate the codebase docs like a knowledge graph.

## 2. External Context (Flavor Text)
- **Requirement:** Every external library, core Flutter widget, or third-party API property used MUST be documented with a link and "flavor text".
- **Flavor Text Pattern:** "We use `[Library.function()](https://link-to-docs)` because [context on why we chose this over others or what specific app requirement it fulfills]."
- **No Exceptions:** Even common widgets like `Container` or `ListView` should be contextualized if they are part of a core feature flow.

## 3. Comprehensive Coverage
- **Every Function:** Every single function signature must be listed with its Purpose, Parameters, and Return Value.
- **Structural Code:** Document non-function elements: global providers, route maps, enums, and configuration objects.
- **No Summarization:** Avoid "This file contains various helpers." Document each one.

## 4. Maintenance Trigger
Whenever you:
1. **Create/Modify/Delete** a function or class.
2. **Introduce** a new dependency in `pubspec.yaml` or `requirements.txt`.
3. **Change** a core initialization sequence.

You **MUST** update the corresponding `.md` file in `docs/` using the standards above in the same tool call sequence.

## 5. Automated Validation
- Run the link checker (if available in the environment).
- Perform a "junior dev" pass: Does this document explain the *why* as well as the *how*?
