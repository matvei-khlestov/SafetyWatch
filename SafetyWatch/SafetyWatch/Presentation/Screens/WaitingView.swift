//
//  WaitingView.swift
//  SafetyWatch
//
//  Created by Matvei Khlestov on 29.12.2025.
//

import SwiftUI

struct WaitingView: View {
    
    let lastRecord: SOSRecord?
    let history: [SOSRecord]
    let onOpenLastSOS: () -> Void
    let onOpenHistory: () -> Void
    
    var body: some View {
        ZStack {
            VStack(spacing: 12) {
                Image(systemName: "applewatch")
                    .font(.system(size: 120, weight: .semibold))
                    .foregroundStyle(.secondary)
                
                Text("Waiting for SOS")
                    .font(.system(size: 20, weight: .medium))
                
                Text("The map opens automatically when an SOS signal is received.")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                
                if let lastRecord {
                    LastSOSCardView(lastRecord: lastRecord, onOpen: onOpenLastSOS)
                        .padding(.top, 25)
                }
                
                if !history.isEmpty {
                    Button(action: onOpenHistory) {
                        Text("History")
                            .font(.system(size: 15, weight: .semibold))
                            .frame(width: 160)
                    }
                    .buttonStyle(.bordered)
                    .padding(.top, 6)
                }
            }
            .offset(y: -70)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("SafetyWatch")
    }
}
