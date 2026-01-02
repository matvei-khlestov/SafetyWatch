//
//  SOSHistoryView.swift
//  SafetyWatch
//
//  Created by Matvei Khlestov on 29.12.2025.
//

import SwiftUI
import UIKit

struct SOSHistoryView: View {
    
    // MARK: - Dependencies
    
    @Binding var items: [SOSRecord]
    let onSelect: (SOSRecord) -> Void
    let onClear: () -> Void
    
    // MARK: - State
    
    @State private var isClearAlertPresented: Bool = false
    @State private var swipeCoordinator = SwipeCoordinator()
    
    // MARK: - UI
    
    private var cardTransition: AnyTransition {
        .asymmetric(
            insertion: .opacity.combined(with: .move(edge: .top)),
            removal: .opacity
                .combined(with: .scale(scale: 0.97))
                .combined(with: .move(edge: .trailing))
        )
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 10) {
                ForEach(items) { item in
                    SwipeAction(
                        id: item.id,
                        coordinator: swipeCoordinator,
                        cornerRadius: 16
                    ) {
                        SOSHistoryCardView(item: item)
                            .transition(cardTransition)
                    } actions: {
                        SwipeActionItem(tint: .green, icon: "map") { onSelect(item) }
                        SwipeActionItem(tint: .blue, icon: "doc.on.doc") { copyCoordinates(item) }
                        SwipeActionItem(tint: .red, icon: "trash.fill") { delete(item) }
                    }
                }
            }
            .padding(15)
        }
        .animation(.easeInOut(duration: 0.22), value: items)
        .scrollIndicators(.hidden)
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Clear") { isClearAlertPresented = true }
                    .disabled(items.isEmpty)
            }
        }
        .alert("Clear SOS History?", isPresented: $isClearAlertPresented) {
            Button("Cancel", role: .cancel) {}
            Button("Clear", role: .destructive) { onClear() }
        } message: {
            Text("All SOS entries will be removed. This cannot be undone.")
        }
        .simultaneousGesture(
            TapGesture().onEnded { swipeCoordinator.closeWithoutAnimation() }
        )
        .simultaneousGesture(
            DragGesture(minimumDistance: 1).onChanged { value in
                let isVertical = abs(value.translation.height) > abs(value.translation.width)
                guard isVertical else { return }
                swipeCoordinator.closeWithoutAnimation()
            }
        )
    }
    
    // MARK: - Actions
    
    private func delete(_ record: SOSRecord) {
        SOSHistoryStorage.delete(id: record.id)
        
        if swipeCoordinator.activeID == AnyHashable(record.id) {
            swipeCoordinator.closeWithoutAnimation()
        }
        
        withAnimation(.easeInOut(duration: 0.22)) {
            items.removeAll { $0.id == record.id }
        }
    }
    
    private func copyCoordinates(_ record: SOSRecord) {
        UIPasteboard.general.string = "\(record.latitude), \(record.longitude)"
    }
}
