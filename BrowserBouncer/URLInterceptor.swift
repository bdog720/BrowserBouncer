import Cocoa
import Foundation

/// Defines a structure containing the extracted URL and the source application's bundle identifier.
struct InterceptedRequest {
    let url: URL
    let sourceBundleIdentifier: String?
}

/// Identifies the application that initiated a URL click and extracts the requested URL.
class URLInterceptor {
    
    /// Parses an incoming Apple Event to determine the target URL and the source application.
    ///
    /// - Parameter event: The `NSAppleEventDescriptor` representing the incoming click.
    /// - Returns: An `InterceptedRequest` containing the URL and the source app's bundle ID.
    static func extractRequest(from event: NSAppleEventDescriptor) -> InterceptedRequest? {
        // Extract the destination URL
        guard let urlString = event.paramDescriptor(forKeyword: AEKeyword(keyDirectObject))?.stringValue,
              let url = URL(string: urlString) else {
            return nil
        }
        
        var sourceBundleId: String?
        
        // Attempt to extract the sender PID
        if let pidDescriptor = event.attributeDescriptor(forKeyword: AEKeyword(keySenderPIDAttr)) {
            let pid = pidDescriptor.int32Value
            // If PID exists, find the running application to identify the source bundle ID
            if let runningApp = NSWorkspace.shared.runningApplications.first(where: { $0.processIdentifier == pid }) {
                sourceBundleId = runningApp.bundleIdentifier
            }
        }
        
        // Fallback Logic: If standard PID is hidden (e.g., Electron app), fallback to the frontmost application
        if sourceBundleId == nil {
            if let frontmostApp = NSWorkspace.shared.frontmostApplication {
                sourceBundleId = frontmostApp.bundleIdentifier
            }
        }
        
        return InterceptedRequest(url: url, sourceBundleIdentifier: sourceBundleId)
    }
}
