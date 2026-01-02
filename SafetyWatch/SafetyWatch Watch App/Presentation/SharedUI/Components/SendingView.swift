//
//  SendingView.swift
//  SafetyWatch Watch App Watch App
//
//  Created by Matvei Khlestov on 28.12.2025.
//

import SwiftUI

struct SendingView: View {
    @State private var rotate = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(SOSColors.ringBackground, lineWidth: 10)
            
            Circle()
                .trim(from: 0.08, to: 0.32)
                .stroke(
                    SOSStyle.Gradients.primaryRing,
                    style: StrokeStyle(lineWidth: 10, lineCap: .round)
                )
                .rotationEffect(.degrees(rotate ? 360 : 0))
                .animation(.linear(duration: 0.9).repeatForever(autoreverses: false), value: rotate)
            
            Circle()
                .trim(from: 0.08, to: 0.32)
                .stroke(
                    SOSStyle.Gradients.specular,
                    style: StrokeStyle(lineWidth: 2, lineCap: .round)
                )
                .rotationEffect(.degrees(rotate ? 360 : 0))
                .blur(radius: 0.6)
                .blendMode(.softLight)
        }
        .frame(width: SOSStyle.Sizes.sendingRing, height: SOSStyle.Sizes.sendingRing)
        .onAppear { rotate = true }
    }
}
