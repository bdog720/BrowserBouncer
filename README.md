<div align="center">
  <img src="assets/logo.png" alt="BrowserBouncer Logo" width="128" />
  <h1>BrowserBouncer</h1>
  <p><em>The intelligent web link router for macOS.</em></p>
  <p>
    <img src="https://img.shields.io/badge/Platform-macOS-lightgrey" alt="Platform" />
    <img src="https://img.shields.io/badge/Swift-5.0+-orange.svg" alt="Swift Version" />
    <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" alt="License" />
  </p>
  <a href="https://apps.apple.com/us/app/browserbouncer/id6762415860?mt=12">
    <img src="https://tools.applemediaservices.com/api/badges/download-on-the-mac-app-store/black/en-us?size=250x83" alt="Download on the Mac App Store" width="200" />
  </a>
</div>

<br />

BrowserBouncer is a lightweight, open-source macOS menu bar application that acts as a smart router for your web links. It intercepts standard URL opening events, checks which desktop application sent the request, and instantly routes the link to the correct browser based on your custom rules.

---

## ✨ Features

- 🎯 **Seamless Routing**: Route links from specific apps (e.g., Slack) to specific browsers (e.g., Microsoft Edge) automatically.
- 💬 **Dynamic Interception Prompt**: If an app isn't allow-listed, BrowserBouncer prompts you to choose a browser and optionally remember the choice.
- 🕵️ **Advanced Source Detection**: Accurately identifies source applications, even those hidden behind Electron frameworks or sandboxes (like Discord or VSCode), by using frontmost application fallback logic.

---

## 📸 Screenshots

<div align="center">
  <img src="assets/routing_rules.png" width="48%" alt="Routing Rules" />
  &nbsp;
  <img src="assets/interception_prompt.png" width="48%" alt="Interception Prompt" />
</div>

---

## 🚧 Roadmap

- [ ] **HTML File Handling**: Support opening local `.html` files directly in your chosen browser via BrowserBouncer, rather than requiring a manual "Open With" workaround.
- [ ] **Browser Profile Support**: Allow rules to target specific profiles within a browser (e.g., open work links in your Edge Work profile and personal links in your Edge Personal profile).
- [ ] **Light Mode Support**: Native light theme implementation for the routing interface and setup views.
- [ ] **Cloud Sync**: Optional iCloud syncing for your custom routing rules across multiple Macs.

---

## 📥 Installation

### Mac App Store (Recommended)

The easiest way to get BrowserBouncer is directly from the Mac App Store — no setup required.

<a href="https://apps.apple.com/us/app/browserbouncer/id6762415860?mt=12">
  <img src="https://tools.applemediaservices.com/api/badges/download-on-the-mac-app-store/black/en-us?size=250x83" alt="Download on the Mac App Store" width="200" />
</a>

### Build from Source

Prefer to build it yourself? Clone the repo and build with Xcode:

1. Clone the repository.
2. Open `BrowserBouncer.xcodeproj` in Xcode.
3. Build and run the `BrowserBouncer` scheme.

*Note: Ensure you have `swiftlint` installed (`brew install swiftlint`) as it is used to enforce code styling.*

---

## 💬 Feedback & Issues

Found a bug or have a feature request? We'd love to hear about it. Please [open an issue](https://github.com/bdog720/BrowserBouncer/issues) here on GitHub.

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to open issues or submit pull requests.

## 📄 License

This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for details.

## 💖 Support the Project

If you find BrowserBouncer useful and it saves you from copying and pasting links all day, consider buying me a coffee to support future development!

<a href="https://buymeacoffee.com/bdog720" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 50px !important;width: 217px !important;" ></a>