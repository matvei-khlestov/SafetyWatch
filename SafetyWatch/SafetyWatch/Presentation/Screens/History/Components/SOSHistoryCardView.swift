//
//  SOSHistoryCardView.swift
//  SafetyWatch
//
//  Created by Matvei Khlestov on 02.01.2026.
//

import SwiftUI

struct SOSHistoryCardView: View {

    let item: SOSRecord

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            header
            coordinates
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 15)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 0))
        .contentShape(.rect)
    }

    private var header: some View {
        HStack(spacing: 8) {
            Text("SOS")
                .font(.headline)

            Text("· \(item.date.relativeDescription)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Spacer()

            if item.isResolved {
                Text("Resolved")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var coordinates: some View {
        HStack(spacing: 6) {
            Image(systemName: "location.fill")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.secondary)

            Text("\(item.latitude), \(item.longitude)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
