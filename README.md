# BrowserBouncer

BrowserBouncer is a lightweight, open-source macOS menu bar application that acts as a smart router for your web links. It intercepts standard URL opening events, checks which desktop application sent the request, and instantly routes the link to the correct browser based on your custom rules.

## Features

- **Seamless Routing**: Route links from specific apps (e.g., Slack) to specific browsers (e.g., Microsoft Edge) automatically.
- **Dynamic Interception Prompt**: If an app isn't allow-listed, BrowserBouncer prompts you to choose a browser and optionally remember the choice.
- **Advanced Source Detection**: Accurately identifies source applications, even those hidden behind Electron frameworks or sandboxes (like Discord or VSCode), by using frontmost application fallback logic.

## Screenshots

<!-- TODO: Add screenshots of the prompt and menu bar settings here -->

## Build Instructions

1. Clone the repository.
2. Open `BrowserBouncer.xcodeproj` in Xcode.
3. Build and run the `BrowserBouncer` scheme.

*Note: Ensure you have `swiftlint` installed (`brew install swiftlint`) as it is used to enforce code styling.*

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to open issues or submit pull requests.

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for details.
