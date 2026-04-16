import SwiftUI

/// Central design system definitions for BrowserBouncer.
enum Theme {
    /// Deep obsidian background, matching the bouncer's suit in the App Icon.
    static let bbBackground = Color(NSColor(red: 0.1, green: 0.11, blue: 0.12, alpha: 1.0))
    /// Card background, slightly lighter than the background.
    static let bbCardBackground = Color(NSColor(red: 0.15, green: 0.16, blue: 0.18, alpha: 1.0))
    /// Electric cyan accent derived from the rim lighting on the App Icon.
    static let bbCyan = Color(NSColor(red: 0.0, green: 0.8, blue: 1.0, alpha: 1.0))
    /// Deep crimson accent derived from the velvet rope on the App Icon.
    static let bbCrimson = Color(NSColor(red: 0.9, green: 0.1, blue: 0.2, alpha: 1.0))
}

/// A macOS standard visual effect view bridged for SwiftUI to create frosted glass backgrounds.
struct VisualEffectView: NSViewRepresentable {
    var material: NSVisualEffectView.Material = .popover
    var blendingMode: NSVisualEffectView.BlendingMode = .behindWindow

    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = material
        view.blendingMode = blendingMode
        view.state = .active
        return view
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        nsView.material = material
        nsView.blendingMode = blendingMode
    }
}
