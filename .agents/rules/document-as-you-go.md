---
description: Rule enforcing continuous documentation updates
---

# Document As You Go

When working in the PumpWatch repository, the developer portal located in `docs/` must accurately reflect the codebase at all times.

## Strict Requirement

If your task involves any of the following:
1. **Adding a new external dependency or API.**
2. **Changing a core Riverpod data flow or caching strategy.**
3. **Modifying the `fuel_prices` or `fuel_stations` schema.**
4. **Altering the Push Notification dispatch logic.**

You **MUST** perform the following actions before marking the task complete:
- Review the `docs/architecture.md` file. Does the Mermaid diagram still accurately reflect the system? If not, rewrite the Mermaid diagram.
- Review the sequence diagrams in `docs/flows/`. If you changed the login, map rendering, or data ingestion flows, update the corresponding sequence diagram to logically trace your new code.
- Ensure you have added concise DartDoc (`///`) for all new Flutter Providers or JSDoc (`/** */`) for Edge Functions.

**Documentation is a first-class citizen.** Never submit a PR or finish a feature without ensuring the MkDocs `.md` files are fully up-to-date.
