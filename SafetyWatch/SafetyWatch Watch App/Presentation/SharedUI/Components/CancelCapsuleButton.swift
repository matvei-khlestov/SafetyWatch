//
//  CancelCapsuleButton.swift
//  SafetyWatch Watch App Watch App
//
//  Created by Matvei Khlestov on 28.12.2025.
//

import SwiftUI

struct CancelCapsuleButton: View {
    let title: String
    let action: () -> Void
    
    @State private var pressed = false
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.footnote.weight(.medium))
                .foregroundStyle(Color.white.opacity(0.85))
                .padding(.horizontal, 29)
                .padding(.vertical, 7)
                .background(
                    ZStack {
                        Capsule()
                            .fill(SOSColors.cancelFill)
                        
                        Capsule()
                            .stroke(SOSStyle.Gradients.cancelStroke, lineWidth: 0.6)
                    }
                )
        }
        .buttonStyle(.plain)
        .scaleEffect(pressed ? 0.96 : 1.0)
        .opacity(pressed ? 0.75 : 1.0)
        .animation(.easeOut(duration: 0.12), value: pressed)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in pressed = true }
                .onEnded { _ in pressed = false }
        )
    }
}
