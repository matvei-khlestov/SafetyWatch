//
//  SOSRoundButton.swift
//  SafetyWatch Watch App Watch App
//
//  Created by Matvei Khlestov on 28.12.2025.
//

import SwiftUI

struct SOSRoundButton: View {
    let title: String
    let action: () -> Void
    
    @State private var pulse = false
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color.red.opacity(0.16))
                    .scaleEffect(pulse ? 1.12 : 0.98)
                    .blur(radius: pulse ? 12 : 7)
                    .animation(.easeInOut(duration: 1.05).repeatForever(autoreverses: true), value: pulse)
                
                Circle()
                    .fill(SOSStyle.Gradients.fill)
                
                Circle()
                    .stroke(SOSStyle.Gradients.specular, lineWidth: 1)
                    .blur(radius: 0.3)
                    .opacity(0.7)
                    .blendMode(.screen)
                
                Text(title)
                    .font(.system(size: 30, weight: .medium))
                    .foregroundStyle(.white)
            }
            .frame(width: SOSStyle.Sizes.sosButton, height: SOSStyle.Sizes.sosButton)
        }
        .buttonStyle(.plain)
        .onAppear { pulse = true }
    }
}
