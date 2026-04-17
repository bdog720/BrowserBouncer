import SwiftUI

/// Creates a window displaying the browser selection prompt.
class PromptWindowController: NSWindowController, NSWindowDelegate {
    static var activeControllers: [PromptWindowController] = []
    convenience init(url: URL, sourceBundleId: String) {
        let promptView = BrowserPromptView(url: url, sourceBundleId: sourceBundleId)
            .preferredColorScheme(.dark)
        let hostingController = NSHostingController(rootView: promptView)
        
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 560, height: 320),
            styleMask: [.titled, .closable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        
        window.contentViewController = hostingController
        window.center()
        window.isReleasedWhenClosed = false
        window.titlebarAppearsTransparent = true
        window.titleVisibility = .visible
        window.title = "BrowserBouncer"
        window.backgroundColor = .clear // Let VisualEffectView shine through
        window.appearance = NSAppearance(named: .darkAqua)
        window.level = .floating
        window.makeKeyAndOrderFront(nil)
        
        self.init(window: window)
        window.delegate = self
        PromptWindowController.activeControllers.append(self)
    }
    
    func windowWillClose(_ notification: Notification) {
        PromptWindowController.activeControllers.removeAll { $0 === self }
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
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
            .onHover { hovering in
                isHovering = hovering
            }
    }
}

struct BrowserOption: Identifiable {
    let id: String
    let name: String
    let icon: NSImage?
}

/// A prompt allowing the user to select which browser to open the link with.
struct BrowserPromptView: View {
    let url: URL
    let sourceBundleId: String
    
    @State private var rememberChoice: Bool = false
    @State private var browserOptions: [BrowserOption] = []
    @State private var isAppearing: Bool = false
    
    var body: some View {
        HStack(spacing: 0) {
            // Left Column: Branding and Link Details
            VStack(spacing: 16) {
                Spacer()
                
                Image("BouncerMascot")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .shadow(color: Theme.bbCyan.opacity(0.4), radius: 10, x: 0, y: 0)
                
                VStack(spacing: 8) {
                    Text("Open Link")
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text(url.absoluteString)
                        .font(.system(.footnote, design: .monospaced))
                        .foregroundColor(Theme.bbCyan)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                }
                
                VStack(spacing: 6) {
                    Text("From: \(sourceAppName)")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    
                    Toggle("Remember Choice", isOn: $rememberChoice)
                        .toggleStyle(.switch)
                        .tint(Theme.bbCyan)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            LinearGradient(
                gradient: Gradient(colors: [.clear, Color.white.opacity(0.1), .clear]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(width: 1)
            .padding(.vertical, 24)
            
            // Right Column: Browser Options
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    ForEach(browserOptions) { option in
                        Button {
                            openBrowser(bundleId: option.id)
                        } label: {
                            HStack(spacing: 14) {
                                if let icon = option.icon {
                                    Image(nsImage: icon)
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                }
                                Text(option.name)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(BrowserButtonStyle())
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
                .padding(.bottom, 24)
            }
            .frame(width: 260)
            .mask(
                VStack(spacing: 0) {
                    LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
                        .frame(height: 16)
                    Color.black
                    LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .top, endPoint: .bottom)
                        .frame(height: 16)
                }
            )
        }
        .frame(width: 560, height: 320)
        .padding(.top, 28) // Leave room for standard macOS titlebar and traffic lights
        .background(
            VisualEffectView(material: .popover, blendingMode: .behindWindow)
                .overlay(Theme.bbBackground.opacity(0.85)) // Tint the glass with obsidian
                .ignoresSafeArea()
        )
        .opacity(isAppearing ? 1 : 0)
        .scaleEffect(isAppearing ? 1 : 0.95)
        .onAppear {
            let browsers = RoutingManager.shared.getInstalledBrowsers()
            browserOptions = browsers.map { bundleId in
                BrowserOption(id: bundleId, name: getAppName(for: bundleId) ?? bundleId, icon: getAppIcon(for: bundleId))
            }
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
        NSApplication.shared.windows.first(where: { $0.windowController is PromptWindowController })?.close()
    }
}
