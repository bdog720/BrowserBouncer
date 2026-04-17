import SwiftUI
import AppKit
import Combine

struct EnhancedRule: Identifiable {
    let id: String // sourceBundleId
    let sourceId: String
    let sourceName: String
    let sourceIcon: NSImage?
    let targetId: String
    let targetName: String
    let targetIcon: NSImage?
}

enum RuleGrouping: String, CaseIterable, Identifiable {
    case byApp = "By App"
    case byBrowser = "By Browser"
    var id: String { self.rawValue }
}

class SettingsViewModel: ObservableObject {
    @Published var rules: [EnhancedRule] = []
    
    func loadRules() {
        let rawRules = RoutingManager.shared.rules
        
        let mapped = rawRules.map { (sourceId, targetId) in
            EnhancedRule(
                id: sourceId,
                sourceId: sourceId,
                sourceName: getAppName(for: sourceId) ?? sourceId,
                sourceIcon: getAppIcon(for: sourceId),
                targetId: targetId,
                targetName: getAppName(for: targetId) ?? targetId,
                targetIcon: getAppIcon(for: targetId)
            )
        }.sorted { $0.sourceName.lowercased() < $1.sourceName.lowercased() }
        
        // Execute UI update
        self.rules = mapped
    }
    
    func deleteRule(sourceId: String) {
        RoutingManager.shared.deleteRule(sourceBundleId: sourceId)
        withAnimation(.easeOut) {
            self.rules.removeAll { $0.id == sourceId }
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
    
    private func getAppIcon(for bundleId: String) -> NSImage? {
        guard let appURL = NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleId) else { return nil }
        return NSWorkspace.shared.icon(forFile: appURL.path)
    }
}
