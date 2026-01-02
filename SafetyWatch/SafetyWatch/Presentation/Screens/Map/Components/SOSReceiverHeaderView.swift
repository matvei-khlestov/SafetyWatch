//
//  SOSReceiverHeaderView.swift
//  SafetyWatch
//
//  Created by Matvei Khlestov on 29.12.2025.
//

import SwiftUI

struct SOSReceiverHeaderView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("SafetyWatch (iPhone)")
                .font(.title2)
                .bold()
            
            Text("Ожидаю SOS от часов.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
