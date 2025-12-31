//
//  SOSHistoryView.swift
//  SafetyWatch
//
//  Created by Matvei Khlestov on 29.12.2025.
//

import SwiftUI

struct SOSHistoryView: View {
    
    @Binding var items: [SOSRecord]
    let onSelect: (SOSRecord) -> Void
    let onClear: () -> Void
    
    @State private var isClearAlertPresented: Bool = false
    
    var body: some View {
        List(items) { item in
            Button {
                onSelect(item)
            } label: {
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 8) {
                        Text("SOS")
                            .font(.headline)
                        
                        Text("· \(item.date.relativeDescription)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        if item.isResolved {
                            Text("Resolved")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    Text("\(item.latitude), \(item.longitude)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .buttonStyle(.plain)
        }
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Clear") { isClearAlertPresented = true }
                    .disabled(items.isEmpty)
            }
        }
        .alert("Clear SOS History?", isPresented: $isClearAlertPresented) {
            Button("Cancel", role: .cancel) {}
            Button("Clear", role: .destructive) {
                onClear()
            }
        } message: {
            Text("All SOS entries will be removed. This cannot be undone.")
        }
    }
}
