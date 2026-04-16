//
//  BrowserBouncerApp.swift
//  BrowserBouncer
//
//  Created by Brendon Rother on 16/4/2026.
//

import SwiftUI

@main
struct BrowserBouncerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        // App exists predominantly in the Menu Bar and via dynamic prompt popups.
        MenuBarExtra("BrowserBouncer", systemImage: "macwindow.badge.plus") {
            SettingsView()
                .preferredColorScheme(.dark)
        }
        .menuBarExtraStyle(.window) // Use .window style so we can apply custom SwiftUI layouts instead of a standard Menu
    }
}

