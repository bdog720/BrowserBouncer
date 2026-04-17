import SwiftUI

class ExpandedSettingsWindowController: NSWindowController {
    static let shared = ExpandedSettingsWindowController()

    private init() {
        let expandedView = ExpandedSettingsView()
            .preferredColorScheme(.dark)
        let hostingController = NSHostingController(rootView: expandedView)
        
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 700, height: 500),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        
        window.contentViewController = hostingController
        window.center()
        window.isReleasedWhenClosed = false
        window.titlebarAppearsTransparent = true
        window.titleVisibility = .visible
        window.title = "BrowserBouncer Config"
        window.backgroundColor = .clear
        window.appearance = NSAppearance(named: .darkAqua)
        
        super.init(window: window)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showWindow() {
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
}
