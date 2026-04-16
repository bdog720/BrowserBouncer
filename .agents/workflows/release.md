---
description: Automates the release process for Android and iOS by invoking release-prep, generating store notes, and building release artifacts.
---

# Release Workflow

## Overview

This workflow coordinates the final steps of a production release.

<HARD-GATE>
**ANTIGRAVITY GUARDRAIL:** You must ONLY generate markdown Artifacts first. Do NOT autonomously modify `CHANGELOG.md`, `pubspec.yaml`, or clear `docs/release_notes_draft.md` until you have drafted the proposed release notes in a review artifact and received the "green light" via `notify_user`.
</HARD-GATE>

## Step 1: Release Prep
Follow the `release-prep` workflow first to update the in-app splash screen.
// turbo
```bash
python .agents/scripts/generate_release_data.py
```

## Step 2: App Store & Play Console Summaries
1. Read `docs/release_notes_draft.md`.
2. Generate concise summaries suitable for Google Play Console and Apple App Store (max 500 chars). Write these to `walkthrough.md` for review.

## Step 3: CHANGELOG and Draft Clearance
1. Draft the append to `CHANGELOG.md` under the new version header (e.g. `## [1.0.1] - 2026-03-01`) using the unreleased contents.
2. Draft clearing `docs/release_notes_draft.md` to standard blank template.
3. Present these changes via review (combining with Step 2).

## Step 4: Commit and Build
1. Once approved, apply the CHANGELOG and Draft updates.
2. Update `pubspec.yaml` with the agreed version.
3. Commit all changes: `git commit -am "chore: release version X.Y.Z"`
4. Build the release artifacts:
   - Android: `flutter build appbundle`
   - iOS: Do NOT use flutter build ipa. Use explicit xcodebuild steps:
     ```bash
     # Step 1: Archive
     xcodebuild archive -workspace ios/Runner.xcworkspace -scheme Runner -configuration Release -archivePath /tmp/PumpWatch.xcarchive DEVELOPMENT_TEAM=UCWPZHKNUV CODE_SIGN_STYLE=Automatic | tail -50
     
     # Step 2: Verify Archive (ensure Team ID is present)
     cat /tmp/PumpWatch.xcarchive/Info.plist | grep -A 2 "Team"
     
     # Step 3: Export
     xcodebuild -exportArchive -archivePath /tmp/PumpWatch.xcarchive -exportPath /tmp/PumpWatch-ipa -exportOptionsPlist ios/ExportOptions.plist -allowProvisioningUpdates
     ```
5. Provide the paths to the new build artifacts to the user via a completion message.
   - Android: `build/app/outputs/bundle/release/app-release.aab`
   - iOS: Archive is at `/tmp/PumpWatch.xcarchive` and the generated `.ipa` is in `/tmp/PumpWatch-ipa/`
