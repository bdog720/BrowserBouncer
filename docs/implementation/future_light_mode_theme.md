# Future Light Mode Theme Implementation Design

## 1. Context and Vision
The initial launch of BrowserBouncer features a "Sleek Minimalist Luxury" design aggressively tailored for **Dark Mode**. This aesthetic was drawn directly from the app’s 3D App Icon (an imposing cartoon bouncer in a matte-black tuxedo with distinct neon rim lighting). 

As requested, this document tracks the constraints and styling values for a future update that implements an inverted **Light Mode Theme**, codenamed "White Marble & Sleek Silver."

## 2. Aesthetic Constraints
A simple color inversion (black to white) will look cheap. The light theme must still convey high-end, premium luxury.

*   **Materials over Flats**: Use frosted glass and silver metallic finishes rather than flat gray rectangles. 
*   **Shadows for Depth**: In Dark Mode, depth is created by making colors lighter. In Light Mode, depth is created by soft, broad drop-shadows.
*   **Minimalist & Clean**: The UI should feel like a premium Apple Store display or a high-end quartz countertop.

## 3. The Future Palette
When the `.bbBackground`, `.bbCyan`, and `.bbCrimson` values are refactored to adapt automatically to color environments, here is the structural map:

| UI Element | Property | Light Mode Target (Sleek Silver/Marble) |
| :--- | :--- | :--- |
| **Main Background** | `bbBackground` | Crisp white (`#FFFFFF`) or slightly warm alabaster (`#FBFBFB`). Rely heavily on `NSVisualEffectView` with `material: .hudWindow` or `.popover` to get the macOS frosted glass effect against bright desktops. |
| **Pill / Card Background**| `bbCardBackground` | Sleek Silver/Cool Gray (`#F2F2F7`). Provide a crisp, sharp 10% opacity black drop-shadow underneath. |
| **Primary Text** | `bbTextPrimary` | Pure Black (`#000000`) or very deep slate gray (`#1C1C1E`) for softer contrast. |
| **Secondary Text** | `bbTextSecondary`| Lighter gray (`#8E8E93`). |
| **Active/Hover Accent**| `bbCyan` | Instead of neon cyan (which gets lost on white), shift to a premium sapphire or cobalt blue (`#0A84FF`), or rely on deep silver/chrome borders on hover states. |
| **Destructive Accent** | `bbCrimson` | Cherry red (`#FF3B30`). Minimal usage. |

## 4. Implementation Steps for Future Agent
When instructed to build the Light Theme, perform the following:
1. Update `BrowserBouncer/Theme.swift` color extensions to use asset catalog items (e.g., `Color("bbBackground")`) and define both Any Appearance and Dark Appearance variables in Xcode.
2. Remove `.preferredColorScheme(.dark)` overrides in `BrowserBouncerApp.swift` and the `PromptWindowController` to allow the system to govern the scheme.
3. Review `NSVisualEffectView` usage to ensure the `material` and `blendingMode` look correct against white backgrounds.
4. Add `.shadow()` modifiers to the hover states in `BrowserPromptView` that are only active in Light Mode (since dark mode utilizes glow/neon lines).
