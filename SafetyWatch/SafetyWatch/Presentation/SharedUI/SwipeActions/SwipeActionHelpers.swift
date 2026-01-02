//
//  SwipeActionHelpers.swift
//  SafetyWatch
//
//  Created by Matvei Khlestov on 02.01.2026.
//

import SwiftUI

struct SwipeOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct SwipeCustomTransition: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content.mask {
            GeometryReader {
                let size = $0.size
                Rectangle()
                    .offset(y: phase == .identity ? 0 : -size.height)
            }
            .containerRelativeFrame(.horizontal)
        }
    }
}
