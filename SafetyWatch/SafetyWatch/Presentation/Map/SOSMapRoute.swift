//
//  SOSMapRoute.swift
//  SafetyWatch
//
//  Created by Matvei Khlestov on 29.12.2025.
//

import Foundation
import CoreLocation

struct SOSMapRoute: Hashable, Identifiable {
    let recordId: UUID
    let latitude: Double
    let longitude: Double
    
    var id: UUID { recordId }
    
    init(record: SOSRecord) {
        self.recordId = record.id
        self.latitude = record.latitude
        self.longitude = record.longitude
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var shareText: String {
        let link = "https://maps.apple.com/?ll=\(latitude),\(longitude)"
        return "SOS! Я здесь: \(link)"
    }
}
