//
//  SOSHistoryStorage.swift
//  SafetyWatch
//
//  Created by Matvei Khlestov on 29.12.2025.
//

import Foundation
import CoreLocation

struct SOSHistoryStorage {
    
    private static let key = "safetywatch_sos_history"
    
    static func load() -> [SOSRecord] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([SOSRecord].self, from: data)) ?? []
    }
    
    static func append(coordinate: CLLocationCoordinate2D) -> SOSRecord {
        var items = load()
        let record = SOSRecord(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude,
            date: Date(),
            isResolved: false
        )
        items.insert(record, at: 0)
        save(items)
        return record
    }
    
    static func delete(id: UUID) {
        var items = load()
        items.removeAll { $0.id == id }
        save(items)
    }
    
    static func clearAll() {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    private static func save(_ items: [SOSRecord]) {
        guard let data = try? JSONEncoder().encode(items) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
}
