//
//  SwipeCoordinator.swift
//  SafetyWatch
//
//  Created by Matvei Khlestov on 02.01.2026.
//

import SwiftUI
import Observation

@MainActor
@Observable
final class SwipeCoordinator {
    
    var activeID: AnyHashable?
    
    func closeWithoutAnimation() {
        guard activeID != nil else { return }
        var t = Transaction()
        t.disablesAnimations = true
        withTransaction(t) {
            activeID = nil
        }
    }
    
    func setActive(_ id: AnyHashable) {
        if activeID == id { return }
        
        if activeID != nil {
            var t = Transaction()
            t.disablesAnimations = true
            withTransaction(t) {
                activeID = nil
            }
        }
        
        activeID = id
    }
}
