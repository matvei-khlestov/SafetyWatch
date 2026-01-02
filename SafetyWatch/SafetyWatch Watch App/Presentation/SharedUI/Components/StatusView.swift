//
//  StatusView.swift
//  SafetyWatch Watch App Watch App
//
//  Created by Matvei Khlestov on 28.12.2025.
//

import SwiftUI

struct StatusView: View {
    let title: String
    let symbol: String
    let isSuccess: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: symbol)
                .font(.system(size: 42, weight: .semibold))
                .foregroundStyle(isSuccess ? Color.green : Color.red)
            
            Text(title)
                .font(.headline)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 8)
    }
}
