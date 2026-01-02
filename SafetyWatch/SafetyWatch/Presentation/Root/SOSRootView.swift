//
//  SOSRootView.swift
//  SafetyWatch
//
//  Created by Matvei Khlestov on 28.12.2025.
//

import SwiftUI

struct SOSRootView: View {
    
    @StateObject private var orchestrator = SOSOrchestrator()
    @State private var router = SOSAppRouter()
    
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
                    .removeDuplicates(by: { $0?.id == $1?.id })
            ) { record in
                router.autoOpenLastIfNeeded(record)
            }
            .onAppear {
                orchestrator.start()
                DispatchQueue.main.async {
                    router.markReadyForAutoOpen()
                }
            }
            .onDisappear {
                orchestrator.stop()
            }
        }
    }
}
