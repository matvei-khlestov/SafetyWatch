//
//  SOSRootView.swift
//  SafetyWatch Watch App Watch App
//
//  Created by Matvei Khlestov on 28.12.2025.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = SOSWatchViewModel()
    
    private var isActiveState: Bool {
        switch vm.state {
        case .countdown, .sending:
            return true
        default:
            return false
        }
    }
    
    var body: some View {
        ZStack {
            background
            content
        }
    }
    
    private var background: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if isActiveState {
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color.red.opacity(0.35),
                        Color.black.opacity(0.0)
                    ]),
                    center: .center,
                    startRadius: 10,
                    endRadius: 110
                )
                .ignoresSafeArea()
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch vm.state {
        case .idle:
            VStack(spacing: 10) {
                SOSRoundButton(title: "SOS") {
                    vm.startCountdown()
                }
                
                Text("Tap to start")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 8)
            
        case .countdown(let seconds):
            VStack(spacing: 10) {
                RingCountdownView(
                    seconds: seconds,
                    progress: vm.progress
                )
                
                CancelCapsuleButton(title: "Cancel") {
                    vm.cancel()
                }
                .padding(.top, 12)
            }
            .padding(.horizontal, 8)
            
        case .sending:
            VStack(spacing: 10) {
                SendingView()
                
                Text("Sending…")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 8)
            
        case .sent:
            StatusView(title: "Sent", symbol: "checkmark.circle.fill", isSuccess: true)
            
        case .failed:
            StatusView(title: "Failed", symbol: "xmark.octagon.fill", isSuccess: false)
        }
    }
}
