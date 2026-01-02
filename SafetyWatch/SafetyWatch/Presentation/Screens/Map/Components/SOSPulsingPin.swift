//
//  SOSPulsingPin.swift
//  SafetyWatch
//
//  Created by Matvei Khlestov on 29.12.2025.
//

import SwiftUI

struct SOSPulsingPin: View {
    
    @State private var animate = false
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.red.opacity(0.22))
                .frame(width: 54, height: 54)
                .scaleEffect(animate ? 1.18 : 0.86)
                .opacity(animate ? 0.10 : 0.55)
                .animation(
                    .easeOut(duration: 1.0)
                    .repeatForever(autoreverses: false),
                    value: animate
                )
            
            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.95, green: 0.18, blue: 0.20),
                            Color(red: 0.55, green: 0.06, blue: 0.12)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 18, height: 18)
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.85), lineWidth: 2)
                )
                .shadow(
                    color: Color.red.opacity(0.35),
                    radius: 8,
                    x: 0,
                    y: 0
                )
            
            Image(systemName: "mappin.circle.fill")
                .font(.system(size: 26, weight: .semibold))
                .foregroundStyle(Color.white.opacity(0.92))
                .shadow(
                    color: Color.black.opacity(0.35),
                    radius: 6,
                    x: 0,
                    y: 2
                )
                .offset(y: -22)
        }
        .onAppear { animate = true }
    }
}
