import SwiftUI
import Combine
/// Settings view displayed via the Menu Bar Extra.
struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var grouping: RuleGrouping = .byApp
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Header
            HStack(spacing: 12) {
                Image("BouncerMascot")
                    .resizable()
                    .interpolation(.high)
                    .antialiased(true)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28, height: 28)
                
                Text("BrowserBouncer")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    ExpandedSettingsWindowController.shared.showWindow()
                } label: {
                    Image(systemName: "arrow.up.right.square")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Theme.bbCyan)
                }
                .buttonStyle(.borderless)
                .help("Open Expanded Settings")
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            
            Divider()
                .background(Color.white.opacity(0.1))
            
            // Grouping Control
            if !viewModel.rules.isEmpty {
                Picker("Group By", selection: $grouping) {
                    ForEach(RuleGrouping.allCases) { group in
                        Text(group.rawValue).tag(group)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
            }
            
            RoutingRuleListView(viewModel: viewModel, grouping: $grouping)
                .frame(height: 250) // Fixed height to prevent ScrollView from collapsing in the Menu Bar
            
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
            viewModel.loadRules()
        }
    }
}
