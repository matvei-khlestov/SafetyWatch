//
//  SOSMapBottomPanel.swift
//  SafetyWatch
//
//  Created by Matvei Khlestov on 29.12.2025.
//

import SwiftUI
import CoreLocation

struct SOSMapBottomPanel: View {
    
    @Binding var spanMeters: CLLocationDistance
    let onCenter: () -> Void
    let onOpenInAppleMaps: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Button("Center") { onCenter() }
                    .buttonStyle(.bordered)
                
                Button("Open in Apple Maps") { onOpenInAppleMaps() }
                    .buttonStyle(.borderedProminent)
            }
            
            HStack(spacing: 12) {
                Text("Zoom")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                
                Slider(value: $spanMeters, in: 200...6000, step: 100)
            }
        }
    }
}
