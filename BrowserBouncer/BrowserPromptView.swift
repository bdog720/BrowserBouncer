import SwiftUI

/// Creates a window displaying the browser selection prompt.
class PromptWindowController: NSWindowController {
    convenience init(url: URL, sourceBundleId: String) {
        let promptView = BrowserPromptView(url: url, sourceBundleId: sourceBundleId)
            .preferredColorScheme(.dark)
        let hostingController = NSHostingController(rootView: promptView)
        
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 400, height: 420),
            styleMask: [.titled, .closable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        
        window.contentViewController = hostingController
        window.center()
        window.isReleasedWhenClosed = false
        window.titlebarAppearsTransparent = true
        window.titleVisibility = .hidden
        window.backgroundColor = .clear // Let VisualEffectView shine through
        window.appearance = NSAppearance(named: .darkAqua)
        window.level = .floating
        window.makeKeyAndOrderFront(nil)
        
        self.init(window: window)
    }
}

/// A custom hoverable button style for browser cards
struct BrowserButtonStyle: ButtonStyle {
    @State private var isHovering = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Theme.bbCardBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isHovering ? Theme.bbCyan : Color.clear, lineWidth: 1.5)
                    )
            )
            .scaleEffect(isHovering ? 1.02 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.interpolatingSpring(stiffness: 300, damping: 20), value: isHovering)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
            .onHover { hovering in
                isHovering = hovering
            }
    }
}

/// A prompt allowing the user to select which browser to open the link with.
struct BrowserPromptView: View {
    let url: URL
    let sourceBundleId: String
    
    @State private var rememberChoice: Bool = false
    @State private var installedBrowsers: [String] = []
    @State private var isAppearing: Bool = false
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 12) {
                Text("Open Link")
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                
                VStack(spacing: 8) {
                    Text(url.absoluteString)
                        .font(.system(.footnote, design: .monospaced))
                        .foregroundColor(Theme.bbCyan.opacity(0.8))
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("From: \(sourceAppName)")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.top, 20)
            
            Toggle("Remember for \(sourceAppName)", isOn: $rememberChoice)
                .controlSize(.regular)
                .toggleStyle(.switch)
                .tint(Theme.bbCyan)
                .padding(.vertical, 8)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    ForEach(installedBrowsers, id: \.self) { bundleId in
                        Button(action: {
                            openBrowser(bundleId: bundleId)
                        }) {
                            HStack(spacing: 16) {
                                if let icon = getAppIcon(for: bundleId) {
                                    Image(nsImage: icon)
                                        .resizable()
                                        .frame(width: 36, height: 36)
                                }
                                Text(getAppName(for: bundleId) ?? bundleId)
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(BrowserButtonStyle())
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
        }
        .frame(width: 400, height: 420)
        .background(
            VisualEffectView(material: .popover, blendingMode: .behindWindow)
                .overlay(Theme.bbBackground.opacity(0.85)) // Tint the glass with obsidian
                .ignoresSafeArea()
        )
        .opacity(isAppearing ? 1 : 0)
        .scaleEffect(isAppearing ? 1 : 0.95)
        .onAppear {
            installedBrowsers = RoutingManager.shared.getInstalledBrowsers()
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 0)) {
                isAppearing = true
            }
        }
    }
    
    private var sourceAppName: String {
        getAppName(for: sourceBundleId) ?? sourceBundleId
    }
    
    private func getAppName(for bundleId: String) -> String? {
        if let appURL = NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleId) {
            var name: AnyObject?
            try? (appURL as NSURL).getResourceValue(&name, forKey: .localizedNameKey)
            return name as? String
        }
        return nil
    }
    
    private func getAppIcon(for bundleId: String) -> NSImage? {
        guard let appURL = NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleId) else { return nil }
        return NSWorkspace.shared.icon(forFile: appURL.path)
    }
    
    private func openBrowser(bundleId: String) {
        if rememberChoice {
            RoutingManager.shared.saveRule(sourceBundleId: sourceBundleId, targetBrowserBundleId: bundleId)
        }
        RoutingManager.shared.open(url: url, withBrowserBundleId: bundleId)
        
        // Close the window after routing
        NSApplication.shared.windows.first(where: { $0.contentViewController is NSHostingController<BrowserPromptView> })?.close()
    }
}
