---
name: iOS Configuration and Release Build
description: Strict guidelines and constraints for any task interacting with iOS builds, configuration files, simulator testing, or App Store releases. Use this skill whenever doing ANY iOS-specific work.
---

<HARD-GATE>
**CRITICAL SYSTEM OVERRIDE:** The following rules MUST be applied to ANY iOS task (including compiling for the simulator, debugging, or generating a release IPA). You MUST NOT modify iOS configuration files (`ExportOptions.plist`, `.xcconfig`, `Info.plist`, or Xcode project signing settings) to fix build issues without the user's explicit permission.
</HARD-GATE>

## DO NOT Touch These iOS Configs (EVER)
Whether trying to load the app on an iOS simulator, debugging a build failure, or creating a release, **these settings must remain exactly as they are** and cannot be "fixed" via agent intervention:

1. **`ios/ExportOptions.plist`**: Do not modify it. It requires `signingStyle` set to `automatic` and `method` set to `app-store-connect`. Do not add a `provisioningProfiles` or `signingCertificate` block.
2. **Xcode Build Settings**: Do not change code signing identities to `Apple Distribution` for Release. It MUST remain `Apple Development` with automatic signing enabled so that Xcode handles the promotion natively.
3. No manual provisioning profile management by the agent.

## Release Build Guidelines (IPA Export)

The IPA must be built using **two separate xcodebuild commands**. Do NOT use `flutter build ipa` — it produces an archive with an empty Team ID that cannot be exported.

### Step 1 — Archive

> [!IMPORTANT]
> You MUST include `-destination "generic/platform=iOS"`. Without it, xcodebuild silently selects the placeholder destination (`dvtdevice-DVTiPhonePlaceholder`) which produces an archive with an empty Team ID. This requires the iOS SDK to be installed in Xcode → Settings → Platforms.

```bash
xcodebuild archive \
  -workspace ios/Runner.xcworkspace \
  -scheme Runner \
  -configuration Release \
  -archivePath /tmp/PumpWatch.xcarchive \
  DEVELOPMENT_TEAM=UCWPZHKNUV \
  CODE_SIGN_STYLE=Automatic \
  -destination "generic/platform=iOS" | tail -50
```
Verify the archive succeeded before proceeding — look for `** ARCHIVE SUCCEEDED **` in the output.

### Step 2 — Verify Archive Team
Before exporting, run:
```bash
cat /tmp/PumpWatch.xcarchive/Info.plist | grep -A 2 "Team"
```
> [!NOTE]
> The `Team` field in `Info.plist` may appear empty even after a correct archive when using `generic/platform=iOS` with Automatic signing. This is a known Xcode quirk and is **not a blocker** — the export step resolves signing at export time via `-allowProvisioningUpdates`. Proceed to Step 3.

### Step 3 — Export IPA

```bash
xcodebuild -exportArchive \
  -archivePath /tmp/PumpWatch.xcarchive \
  -exportPath /tmp/PumpWatch-ipa \
  -exportOptionsPlist ios/ExportOptions.plist \
  -allowProvisioningUpdates
```
The IPA will be output to `/tmp/PumpWatch-ipa/`.
