//
//  LastSOSCardView.swift
//  SafetyWatch
//
//  Created by Matvei Khlestov on 29.12.2025.
//

import SwiftUI

struct LastSOSCardView: View {
    
    let lastRecord: SOSRecord
    let onOpen: () -> Void
    
    var body: some View {
        Button(action: onOpen) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    Circle()
                        .fill(Color.red.opacity(0.9))
                        .frame(width: 8, height: 8)
                    
                    Text("Last SOS · \(lastRecord.date.relativeDescription)")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.primary)
                    
                    Spacer()
                    
                    if lastRecord.isResolved {
                        Text("Resolved")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.secondary)
                    }
                }
                
                Text("Tap to open map")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 24)
    }
}
