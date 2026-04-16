---
name: frontend-design
description: Create distinctive, production-grade frontend interfaces with high design quality. Use this skill when building Flutter screens, widgets, or themes. Generates creative, polished code that avoids generic AI aesthetics.
---

This skill guides creation of distinctive, production-grade frontend interfaces that avoid generic "AI slop" aesthetics. Implement real working code with exceptional attention to aesthetic details and creative choices.

## Design Direction

Commit to a BOLD aesthetic direction:
- **Purpose**: What problem does this interface solve? Who uses it?
- **Tone**: Pick an extreme: brutally minimal, maximalist chaos, retro-futuristic, organic/natural, luxury/refined, playful/toy-like, editorial/magazine, brutalist/raw, art deco/geometric, soft/pastel, industrial/utilitarian, etc.
- **Constraints**: Technical requirements (Flutter, performance, accessibility).
- **Differentiation**: What makes this UNFORGETTABLE?

**CRITICAL**: Choose a clear conceptual direction and execute it with precision. Bold maximalism and refined minimalism both work—the key is intentionality, not intensity.

Then implement working code that is:
- Production-grade and functional (Flutter/Dart)
- Visually striking and memorable
- Cohesive with a clear aesthetic point-of-view
- Meticulously refined in every detail

## Frontend Aesthetics Guidelines

### Typography
→ *Consult [typography reference](reference/typography.md) for scales, pairing, and loading strategies.*

**DO**: Use a modular type scale with fluid sizing.
**DON'T**: Use overused fonts—Inter, Roboto, Arial, system defaults.

### Color & Theme
→ *Consult [color reference](reference/color-and-contrast.md) for OKLCH, palettes, and dark mode.*

**DO**: Use modern CSS color functions (or Flutter equivalent `Color.lerp`, `HCT` from Material 3) for perceptually uniform palettes.
**DO**: Tint your neutrals toward your brand hue.
**DON'T**: Use gray text on colored backgrounds.

### Layout & Space
→ *Consult [spatial reference](reference/spatial-design.md) for grids, rhythm, and container queries.*

**DO**: Create visual rhythm through varied spacing—tight groupings, generous separations.
**DON'T**: Wrap everything in cards—not everything needs a container.

### Visual Details
**DO**: Use intentional, purposeful decorative elements that reinforce brand.
**DON'T**: Use glassmorphism everywhere.

### Motion
→ *Consult [motion reference](reference/motion-design.md) for timing, easing, and reduced motion.*

**DO**: Use motion to convey state changes—entrances, exits, feedback.
**DO**: Use exponential easing for natural deceleration.

### Interaction
→ *Consult [interaction reference](reference/interaction-design.md) for forms, focus, and loading patterns.*

**DO**: Use progressive disclosure—start simple, reveal sophistication through interaction.
**DON'T**: Make every button primary—use ghost buttons, text links, secondary styles.

### Responsive
→ *Consult [responsive reference](reference/responsive-design.md).*

**DO**: Adapt the interface for different contexts—don't just shrink it.

### UX Writing
→ *Consult [ux-writing reference](reference/ux-writing.md).*

**DO**: Make every word earn its place.

---

## The AI Slop Test

**Critical quality check**: If you showed this interface to someone and said "AI made this," would they believe you immediately? If yes, that's the problem.

---

## Implementation Principles

Match implementation complexity to the aesthetic vision. Maximalist designs need elaborate code with extensive animations and effects. Minimalist or refined designs need restraint, precision, and careful attention to spacing, typography, and subtle details.
