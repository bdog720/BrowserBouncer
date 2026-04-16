# Local CLI Environment Rule

**CRITICAL SYSTEM RULE:** When running terminal commands in this project (such as `flutter`, `python3`, `dart`, `npm`, etc.), the shell may not have the user's `$PATH` natively loaded. To guarantee tools are found without command not found errors, you MUST ALWAYS prefix any executing CLI commands with `source ~/.zprofile && `.

Example:
❌ DO NOT use: `flutter pub get`
✅ INSTEAD use: `source ~/.zprofile && flutter pub get`

❌ DO NOT use: `python3 script.py`
✅ INSTEAD use: `source ~/.zprofile && python3 script.py`

This ensures the user's correct homebrew paths, local aliases, and Flutter/Dart environments are properly loaded into the agent's headless shell before execution. Do not waste time manually searching for the path to the executable.

### Handling Missing Tools

If you have sourced `~/.zprofile` and a required CLI tool is legitimately not installed or still cannot be found:
1. **DO NOT** attempt to install it yourself inside the ephemeral AntiGravity environment.
2. **STOP** and clearly report the missing tool to the USER.
3. Provide the USER with the exact terminal command(s) (e.g., `brew install ...`) they need to run on their own external terminal to install the tool globally on their machine.

This ensures tools are installed correctly on the host machine and are available for both the user and future agents.
