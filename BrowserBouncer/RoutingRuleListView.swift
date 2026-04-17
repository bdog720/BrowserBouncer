import SwiftUI
import Combine

struct RoutingRuleListView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @Binding var grouping: RuleGrouping
    
    var body: some View {
        if viewModel.rules.isEmpty {
            Text("No routing rules configured yet.\n\nRules are added when you click a link and select 'Remember'.")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.vertical, 32)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 8) {
                    if grouping == .byApp {
                        // linear standard list
                        ForEach(viewModel.rules) { rule in
                            RuleCard(rule: rule, showBrowserDestination: true) {
                                viewModel.deleteRule(sourceId: rule.id)
                            }
                        }
                    } else {
                        // grouped list by target browser
                        let grouped = Dictionary(grouping: viewModel.rules, by: { $0.targetId })
                        let sortedKeys = grouped.keys.sorted {
                            (grouped[$0]?.first?.targetName ?? "").lowercased() < (grouped[$1]?.first?.targetName ?? "").lowercased()
                        }
                        
                        ForEach(sortedKeys, id: \.self) { targetId in
                            if let rulesForGroup = grouped[targetId], let firstRule = rulesForGroup.first {
                                VStack(alignment: .leading, spacing: 6) {
                                    HStack(spacing: 8) {
                                        if let icon = firstRule.targetIcon {
                                            Image(nsImage: icon)
                                                .resizable()
                                                .frame(width: 16, height: 16)
                                        }
                                        Text(firstRule.targetName)
                                            .font(.system(size: 13, weight: .bold))
                                            .foregroundColor(Theme.bbCyan)
                                        Spacer()
                                    }
                                    .padding(.top, 12)
                                    .padding(.bottom, 4)
                                    .padding(.horizontal, 4)
                                    
                                    ForEach(rulesForGroup) { rule in
                                        RuleCard(rule: rule, showBrowserDestination: false) {
                                            viewModel.deleteRule(sourceId: rule.id)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(16)
                .padding(.bottom, 16)
            }
        }
    }
}

struct RuleCard: View {
    let rule: EnhancedRule
    let showBrowserDestination: Bool
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            if let icon = rule.sourceIcon {
                Image(nsImage: icon)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(rule.sourceName)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.white)
                
                if showBrowserDestination {
                    HStack(spacing: 4) {
                        Text("Routes to \(rule.targetName)")
                            .font(.system(size: 11))
                            .foregroundColor(Theme.bbCyan.opacity(0.8))
                    }
                }
            }
            
            Spacer()
            
            Button("Remove") {
                onDelete()
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
