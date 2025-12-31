//
//  ContentView.swift
//  SafetyWatch
//
//  Created by Matvei Khlestov on 28.12.2025.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var orchestrator = SOSOrchestrator()
    @StateObject private var router = SOSAppRouter()

    @State private var didFinishInitialLoad: Bool = false

    var body: some View {
        NavigationStack(path: $router.path) {
            WaitingView(
                lastRecord: orchestrator.lastRecord,
                history: orchestrator.history,
                onOpenLastSOS: { router.openLast(orchestrator.lastRecord) },
                onOpenHistory: { router.openHistory() }
            )
            .navigationDestination(for: SOSRoute.self) { route in
                switch route {
                case .map(let mapRoute):
                    SOSMapView(
                        coordinate: mapRoute.coordinate,
                        shareText: mapRoute.shareText
                    )

                case .history:
                    SOSHistoryView(
                        items: $orchestrator.history,
                        onSelect: { record in router.openFromHistory(record) },
                        onClear: { orchestrator.clearHistory() }
                    )
                }
            }
            .onReceive(
                orchestrator.$lastRecord
                    .compactMap { $0 }
                    .removeDuplicates(by: { a, b in a.id == b.id })
            ) { record in
                guard didFinishInitialLoad else { return }
                router.open(record)
            }
            .onAppear {
                orchestrator.start()
                DispatchQueue.main.async { didFinishInitialLoad = true }
            }
            .onDisappear {
                orchestrator.stop()
            }
        }
    }
}
