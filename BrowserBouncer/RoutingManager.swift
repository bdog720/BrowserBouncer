import Cocoa
import Foundation

/// Manages routing rules and opens URLs in the requested web browser.
class RoutingManager {
    
    /// The singleton instance of the routing manager.
    static let shared = RoutingManager()
    
    // UserDefaults key for our saved rules.
    private let rulesKey = "BrowserBouncerRules"
    
    // A dictionary mapping source app bundle IDs to target browser bundle IDs.
    private(set) var rules: [String: String] = [:]
    
    private init() {
        loadRules()
    }
    
    /// Loads the saved rules from UserDefaults.
    private func loadRules() {
        if let savedRules = UserDefaults.standard.dictionary(forKey: rulesKey) as? [String: String] {
            rules = savedRules
        }
    }
    
    /// Saves a new rule mapping a source app to a target browser.
    ///
    /// - Parameters:
    ///   - sourceBundleId: The bundle identifier of the application clicking the link.
    ///   - targetBrowserBundleId: The bundle identifier of the specific browser to open.
    func saveRule(sourceBundleId: String, targetBrowserBundleId: String) {
        rules[sourceBundleId] = targetBrowserBundleId
        UserDefaults.standard.set(rules, forKey: rulesKey)
    }
    
    /// Deletes a rule for a specific source application.
    ///
    /// - Parameter sourceBundleId: The bundle identifier to remove from rules.
    func deleteRule(sourceBundleId: String) {
        rules.removeValue(forKey: sourceBundleId)
        UserDefaults.standard.set(rules, forKey: rulesKey)
    }
    
    /// Opens the specified URL using the provided browser bundle ID.
    ///
    /// - Parameters:
    ///   - url: The destination URL to open.
    ///   - bundleId: The target browser bundle identifier.
    func open(url: URL, withBrowserBundleId bundleId: String) {
        guard let appURL = NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleId) else {
            print("Could not find browser with bundle ID: \(bundleId)")
            return
        }
        
        let configuration = NSWorkspace.OpenConfiguration()
        NSWorkspace.shared.open([url], withApplicationAt: appURL, configuration: configuration) { _, error in
            if let error = error {
                print("Failed to open URL: \(error.localizedDescription)")
            }
        }
    }
    
    /// Finds and returns a list of installed web browsers on macOS.
    ///
    /// - Returns: An array of bundle identifiers for common browsers.
    func getInstalledBrowsers() -> [String] {
        // macOS does not provide a robust native API to easily query *all* installed browsers via LaunchServices in Swift simply,
        // so we check common bundle identifiers using NSWorkspace to see if they're installed.
        let knownBrowsers = [
            "com.apple.Safari",
            "com.google.Chrome",
            "org.mozilla.firefox",
            "com.microsoft.edgemac",
            "com.brave.Browser",
            "company.thebrowser.Browser", // Arc
            "com.vivaldi.Vivaldi"
        ]
        
        return knownBrowsers.filter { bundleId in
            NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleId) != nil
        }
    }
}
