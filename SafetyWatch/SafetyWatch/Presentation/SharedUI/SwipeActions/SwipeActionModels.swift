//
//  SwipeActionModels.swift
//  SafetyWatch
//
//  Created by Matvei Khlestov on 02.01.2026.
//

import SwiftUI

struct SwipeActionItem: Identifiable {
    private(set) var id: UUID = .init()
    var tint: Color
    var icon: String
    var iconFont: Font = .system(size: 20, weight: .medium)
    var iconTint: Color = .white
    var isEnabled: Bool = true
    var action: @MainActor () -> Void
    
    init(
        tint: Color,
        icon: String,
        iconFont: Font = .system(size: 20, weight: .medium),
        iconTint: Color = .white,
        isEnabled: Bool = true,
        action: @escaping @MainActor () -> Void
    ) {
        self.tint = tint
        self.icon = icon
        self.iconFont = iconFont
        self.iconTint = iconTint
        self.isEnabled = isEnabled
        self.action = action
    }
}

@resultBuilder
struct SwipeActionBuilder {
    static func buildBlock(_ components: SwipeActionItem...) -> [SwipeActionItem] {
        components
    }
}
