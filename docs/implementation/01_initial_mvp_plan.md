# BrowserBouncer Implementation Plan

This plan details the architecture and micro-tasks required to build an open-source, native macOS browser picker. It incorporates the `frontmostApplication` fallback logic to identify the source application even when standard PIDs are hidden by sandboxing or Electron frameworks. It also adheres to standard open-source Swift practices.

## Proposed Changes

### Open Source & Project Initialization
#### [NEW] BrowserBouncer/
- **Micro-task 1:** The **USER** must open Xcode, select "File > New > Project > macOS App", name it `BrowserBouncer`, and save it in the project root directory. (Headless AI agents cannot reliably generate `.xcodeproj` files from scratch).
- **Micro-task 2:** Modify the main target configuration to build a macOS app.
- **Micro-task 3:** Create a standard open-source `README.md` with build instructions, features, and screenshots placeholder.
- **Micro-task 4:** Create a `LICENSE` file (Apache 2.0).
- **Micro-task 5:** Create a `CONTRIBUTING.md` outlining how to open PRs or issues.
- **Micro-task 6:** Integrate `SwiftLint` as a build phase script to enforce unified code styling across all future open-source contributions. 

### Core Foundation
#### [MODIFY] BrowserBouncer/Info.plist
- **Micro-task 1:** Add the `CFBundleURLTypes` array to register the app as an active handler for `http` and `https` URL schemes.
- **Micro-task 2:** Add `LSUIElement` set to `YES` so the app runs as a menu bar extra (background agent) without a Dock icon.

#### [NEW] BrowserBouncer/AppDelegate.swift
- **Micro-task 3:** Create `AppDelegate` conforming to `NSApplicationDelegate` with proper Swift `///` docstrings for OSS maintainability.
- **Micro-task 4:** Register `NSAppleEventManager.shared().setEventHandler` for `kInternetEventClass` / `kAEGetURL` in `applicationWillFinishLaunching`.

### URL Interception & Parsing
#### [NEW] BrowserBouncer/URLInterceptor.swift
- **Micro-task 1:** Create `URLInterceptor` class containing the event handler method.
- **Micro-task 2:** Within the handler, extract the destination URL.
- **Micro-task 3:** Extract the sender PID using `keySenderPIDAttr`.
- **Micro-task 4:** If PID exists, use `NSWorkspace.shared.runningApplications` to identify the source.
- **Micro-task 5:** **Fallback Logic:** If PID is missing, query `NSWorkspace.shared.frontmostApplication` to identify the source application.

### State & Routing Logic
#### [NEW] BrowserBouncer/RoutingManager.swift
- **Micro-task 1:** Create `RoutingManager` class to manage rules (source app -> target browser).
- **Micro-task 2:** Implement `saveRule` using `UserDefaults.standard`.
- **Micro-task 3:** Implement `open(url:withBrowserBundleId:)` using `NSWorkspace.shared.open()` to launch the target browser.
- **Micro-task 4:** Query macOS for a list of locally installed web browsers to populate UI options.

### User Interface 
#### [NEW] BrowserBouncer/BrowserPromptView.swift
- **Micro-task 1:** Create a SwiftUI View that displays when an unrecognized app attempts to open a link.
- **Micro-task 2:** Present the destination URL and the name of the source application.
- **Micro-task 3:** List available installed browsers as selectable buttons with a "Remember for [App Name]" toggle.
- **Micro-task 4:** Hook up selection events to `RoutingManager`.

#### [NEW] BrowserBouncer/SettingsView.swift
- **Micro-task 1:** Create a Menu Bar popover view.
- **Micro-task 2:** List all currently saved routing rules with delete options.

#### [MODIFY] BrowserBouncer/BrowserBouncerApp.swift
- **Micro-task 1:** Incorporate `AppDelegate` via `@NSApplicationDelegateAdaptor`.
- **Micro-task 2:** Use `MenuBarExtra` to display the app in the macOS menu bar.

## Verification Plan

### Automated Tests
- `source ~/.zprofile && swiftlint` to verify code quality.
- `source ~/.zprofile && xcodebuild build -project BrowserBouncer.xcodeproj -scheme BrowserBouncer` to ensure no build errors.

### Manual Verification
1. Open the project in Xcode, build, and run the application.
2. Ensure the icon appears in the macOS menu bar.
3. Open macOS **System Settings > Desktop & Dock > Default web browser** and select `BrowserBouncer`.
4. Open Apple **Notes** and click a hyperlink `https://example.com`.
5. Verify the `BrowserPromptView` popup appears asking which browser to use.
6. Select an installed browser, toggle "Remember", and verify the link successfully opens.
7. Click another link in Apple **Notes** and verify it immediately opens in the chosen browser without prompting.
8. Click a link in a sandboxed/Electron app (e.g., Discord), and verify the popup accurately identifies the source app using the fallback logic.
