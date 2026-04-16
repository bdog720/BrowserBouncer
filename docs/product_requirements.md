# BrowserBouncer: Product Requirements Document

## 1. Problem Statement
Many users have separate browsers for distinct workflows (e.g., Microsoft Edge for work, Firefox for personal use). When clicking hyperlinks in desktop applications (like Slack, iMessage, Mail, or a terminal), macOS invariably routes the link to a single system default browser. 

This creates constant friction:
* Work links open in personal browsers without active login sessions.
* Personal links open in work browsers, mixing browsing history and contexts.
* The user is forced to manually copy-paste URLs between browsers.

## 2. Product Vision
**BrowserBouncer** is a lightweight, open-source macOS menu bar application built to solve this problem. It acts as the system's default browser on paper, but acts as a smart router in practice. It intercepts standard URL opening events, checks which desktop application sent the request, and instantly routes the link to the correct browser based on user-defined rules.

### Competitor Landscape & Inspiration
* **Velja**: A popular, GUI-based router. BrowserBouncer aims to replicate its seamless routing functionality and ease of use, particularly its robust handling of edge cases (like Electron apps obscuring their process IDs).
* **Finicky / Choosy**: Alternative routers that are either paid or rely heavily on complex configuration files rather than a native, simple UI.

## 3. Core Features & Requirements

### 3.1 Seamless Routing via Allow-lists
* Users can map specific source applications (e.g., "Slack") to specific target browsers (e.g., "Microsoft Edge").
* When a link is clicked in an allow-listed application, the link opens automatically in the designated browser with zero visual interruption.

### 3.2 Dynamic Interception Prompt
* If a link is clicked from an application that *is not* in the allow-list, BrowserBouncer must intercept the request and immediately display a small UI prompt.
* The prompt must display the URL and the source application name.
* The prompt must list all locally installed web browsers as clickable options.
* The prompt must include a "Remember for [App Name]" checkbox. If checked, the selection is immediately saved to the permanent allow-list.

### 3.3 The "Electron" Source Fallback
* **Context:** By default, macOS URL handlers pass along the Process ID (`PID`) of the app that clicked the link. However, many modern Electron apps (like Discord or VSCode) run inside sandboxes that obscure this PID, arriving at our app as an "Unknown Source".
* **Requirement:** To achieve parity with tools like Velja, BrowserBouncer must implement a fallback mechanism. When the `keySenderPIDAttr` is missing, the application must immediately query `NSWorkspace.shared.frontmostApplication` to accurately deduce the clicking application.

## 4. Technical Constraints & Tech Stack
* **OS:** macOS only.
* **Language:** Swift 5+
* **Framework:** SwiftUI for all user interfaces (Prompts, Menu Bar settings).
* **APIs:** Extensive use of `NSAppleEventManager` (URL interception) and `NSWorkspace` (Browser discovery and launching).
* **Storage:** Apple `UserDefaults` for rule persistence.

## 5. Open Source Philosophy & Governance
This project is built explicitly for the community. The author, while building this originally for personal utility, desires it to meet high open-source standards. 

* **License:** Apache License 2.0. (Chosen for its permissive nature while offering vital software patent protections, heavily influenced by open-source advocates like Simon Willison).
* **Code Quality:** The project will utilize `SwiftLint` in its build phase to ensure style uniformity for all future PRs.
* **Documentation:** `README.md` and `CONTRIBUTING.md` must be maintained alongside the codebase. Code must contain adequate `///` Swift docstrings.
