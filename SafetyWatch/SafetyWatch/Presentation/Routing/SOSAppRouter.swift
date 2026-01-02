//
//  SOSAppRouter.swift
//  SafetyWatch
//
//  Created by Matvei Khlestov on 31.12.2025.
//

import Observation

@MainActor
@Observable
final class SOSAppRouter {
    
    var path: [SOSRoute] = [] {
        didSet {
            if path.isEmpty {
                isAutoOpenSuppressed = false
            }
        }
    }
    
    private var isReadyForAutoOpen: Bool = false
    private var isAutoOpenSuppressed: Bool = false
    private var lastAutoOpenedID: AnyHashable?
    
    // MARK: - Lifecycle
    
    func markReadyForAutoOpen() {
        isReadyForAutoOpen = true
    }
    
    // MARK: - Auto open
    
    func autoOpenLastIfNeeded(_ record: SOSRecord?) {
        guard isReadyForAutoOpen else { return }
        guard !isAutoOpenSuppressed else { return }
        guard path.isEmpty else { return }
        guard let record else { return }
        
        let rid = AnyHashable(record.id)
        guard lastAutoOpenedID != rid else { return }
        lastAutoOpenedID = rid
        
        path.append(.map(SOSMapRoute(record: record)))
    }
    
    // MARK: - Manual navigation
    
    func open(_ record: SOSRecord) {
        suppressAutoOpen()
        path.append(.map(SOSMapRoute(record: record)))
    }
    
    func openLast(_ record: SOSRecord?) {
        guard let record else { return }
        open(record)
    }
    
    func openHistory() {
        suppressAutoOpen()
        path.append(.history)
    }
    
    func openFromHistory(_ record: SOSRecord) {
        suppressAutoOpen()
        path.append(.map(SOSMapRoute(record: record)))
    }
    
    // MARK: - Private
    
    private func suppressAutoOpen() {
        isAutoOpenSuppressed = true
    }
}
