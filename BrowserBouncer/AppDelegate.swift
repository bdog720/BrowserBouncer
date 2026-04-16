import Cocoa
import Foundation

/// Defines the application delegate for the macOS app lifecycle.
///
/// This delegate registers the app to handle incoming HTTP/HTTPS URL clicks system-wide.
class AppDelegate: NSObject, NSApplicationDelegate {

    /// Called immediately before the application has finished launching.
    /// Used to register the Apple Events handler for incoming URLs.
    func applicationWillFinishLaunching(_ notification: Notification) {
        NSAppleEventManager.shared().setEventHandler(
            self,
            andSelector: #selector(handleGetURLEvent(event:withReplyEvent:)),
            forEventClass: AEEventClass(kInternetEventClass),
            andEventID: AEEventID(kAEGetURL)
        )
    }

    /// Handles incoming Apple Events specifically for `kAEGetURL`.
    ///
    /// - Parameters:
    ///   - event: The incoming Apple Event containing the URL and source application metadata.
    ///   - replyEvent: The reply event to populate if needed.
    @objc func handleGetURLEvent(event: NSAppleEventDescriptor, withReplyEvent replyEvent: NSAppleEventDescriptor) {
        guard let request = URLInterceptor.extractRequest(from: event) else {
            print("Failed to intercept URL event.")
            return
        }
        
        let sourceBundleId = request.sourceBundleIdentifier ?? "UnknownSource"
        
        // Check if we have a saved rule for this source application
        if let targetBrowserId = RoutingManager.shared.rules[sourceBundleId] {
            RoutingManager.shared.open(url: request.url, withBrowserBundleId: targetBrowserId)
        } else {
            // Prompt the user to select a browser
            DispatchQueue.main.async {
                _ = PromptWindowController(url: request.url, sourceBundleId: sourceBundleId)
            }
        }
    }
}
