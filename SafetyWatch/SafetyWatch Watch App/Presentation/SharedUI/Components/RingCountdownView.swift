//
//  RingCountdownView.swift
//  SafetyWatch Watch App Watch App
//
//  Created by Matvei Khlestov on 28.12.2025.
//

import SwiftUI

struct RingCountdownView: View {
    let seconds: Int
    let progress: Double
    
    @State private var breathe = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(SOSColors.ringBackground, lineWidth: 10)
            
            Circle()
                .trim(from: 0, to: max(0.02, progress))
                .stroke(
                    SOSStyle.Gradients.primaryRing,
                    style: StrokeStyle(lineWidth: 10, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .scaleEffect(breathe ? 1.012 : 0.992)
                .animation(.linear(duration: 0.25), value: progress)
                .animation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true), value: breathe)
            
            Circle()
                .trim(from: 0, to: max(0.02, progress))
                .stroke(
                    SOSStyle.Gradients.specular,
                    style: StrokeStyle(lineWidth: 2, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .blur(radius: 0.6)
                .blendMode(.softLight)
            
            VStack(spacing: 2) {
                Text("\(seconds)")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                
                Text("seconds")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(width: SOSStyle.Sizes.ring, height: SOSStyle.Sizes.ring)
        .onAppear { breathe = true }
    }
}
