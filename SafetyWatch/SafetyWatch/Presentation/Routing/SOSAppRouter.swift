//
//  SOSAppRouter.swift
//  SafetyWatch
//
//  Created by Matvei Khlestov on 31.12.2025.
//

import Foundation

final class SOSAppRouter: ObservableObject {

    @Published var path: [SOSRoute] = []

    func open(_ record: SOSRecord) {
        path.append(.map(SOSMapRoute(record: record)))
    }

    func openLast(_ record: SOSRecord?) {
        guard let record else { return }
        open(record)
    }

    func openHistory() {
        path.append(.history)
    }

    func openFromHistory(_ record: SOSRecord) {
        if path.last == .history {
            path.append(.map(SOSMapRoute(record: record)))
        } else {
            open(record)
        }
    }
}
