import SwiftUI
import Combine

struct ExpandedSettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var grouping: RuleGrouping = .byApp
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Header
            HStack {
                Image("BouncerMascot")
                    .resizable()
                    .interpolation(.high)
                    .antialiased(true)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 48, height: 48)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("BrowserBouncer Settings")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("Manage your routed applications")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Picker("Group By", selection: $grouping) {
                    ForEach(RuleGrouping.allCases) { group in
                        Text(group.rawValue).tag(group)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 260)
            }
            .padding(24)
            
            Divider()
                .background(Color.white.opacity(0.1))
            
            RoutingRuleListView(viewModel: viewModel, grouping: $grouping)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(minWidth: 500, minHeight: 400)
        .background(
            VisualEffectView(material: .popover, blendingMode: .behindWindow)
                .overlay(Theme.bbBackground.opacity(0.85))
                .ignoresSafeArea()
        )
        .onAppear {
            viewModel.loadRules()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSApplication.willBecomeActiveNotification)) { _ in
            viewModel.loadRules()
        }
    }
}
