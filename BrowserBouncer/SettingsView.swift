import SwiftUI

/// Settings view displayed via the Menu Bar Extra.
/// Lists active rules mapping source apps to target browsers.
struct SettingsView: View {
    @State private var rules: [(key: String, value: String)] = []
    
    var body: some View {
        VStack(spacing: 0) {
            Text("BrowserBouncer Settings")
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .padding(.vertical, 16)
            
            Divider()
                .background(Color.white.opacity(0.1))
            
            if rules.isEmpty {
                Text("No routing rules configured yet.\n\nRules are added when you click a link and select 'Remember'.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 32)
                    .padding(.horizontal)
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 8) {
                        ForEach(rules, id: \.key) { rule in
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("\(getAppName(for: rule.key) ?? rule.key)")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(.white)
                                    Text("Routes to \(getAppName(for: rule.value) ?? rule.value)")
                                        .font(.system(size: 11))
                                        .foregroundColor(Theme.bbCyan.opacity(0.8))
                                }
                                Spacer()
                                Button("Remove") {
                                    deleteRule(sourceId: rule.key)
                                }
                                .buttonStyle(.borderless)
                                .foregroundColor(Theme.bbCrimson)
                                .font(.system(size: 12, weight: .medium))
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 16)
                            .background(Theme.bbCardBackground)
                            .cornerRadius(8)
                            .transition(.asymmetric(insertion: .opacity, removal: .scale(scale: 0.9).combined(with: .opacity)))
                        }
                    }
                    .padding(16)
                }
                .frame(maxHeight: 250) // Bounded height for the menu bar popup
            }
            
            Divider()
                .background(Color.white.opacity(0.1))
            
            HStack {
                Button("Quit BrowserBouncer") {
                    NSApplication.shared.terminate(nil)
                }
                .keyboardShortcut("q", modifiers: .command)
                .buttonStyle(.borderless)
                .foregroundColor(.secondary)
                .padding()
                
                Spacer()
            }
        }
        .frame(width: 350)
        .background(Theme.bbBackground) // Apply the deep obsidian background to the menu bar popup
        .onAppear {
            refreshRules()
        }
    }
    
    private func refreshRules() {
        // Retrieve directly from the shared manager rules dictionary
        let currentRules = RoutingManager.shared.rules
        // Convert to sorted array for consistent display
        withAnimation(.spring()) {
            self.rules = currentRules.map { (key: $0.key, value: $0.value) }.sorted(by: { $0.key < $1.key })
        }
    }
    
    private func deleteRule(sourceId: String) {
        RoutingManager.shared.deleteRule(sourceBundleId: sourceId)
        withAnimation(.easeOut(duration: 0.2)) {
            rules.removeAll { $0.key == sourceId }
        }
        // Sync back with the main source of truth on the next UI tick
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            refreshRules()
        }
    }
    
    private func getAppName(for bundleId: String) -> String? {
        if let appURL = NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleId) {
            var name: AnyObject?
            try? (appURL as NSURL).getResourceValue(&name, forKey: .localizedNameKey)
            return name as? String
        }
        return nil
    }
}
