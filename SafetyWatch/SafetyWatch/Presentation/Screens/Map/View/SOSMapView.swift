//
//  SOSMapView.swift
//  SafetyWatch
//
//  Created by Matvei Khlestov on 29.12.2025.
//

import SwiftUI
import MapKit

struct SOSMapView: View {
    
    let coordinate: CLLocationCoordinate2D
    let shareText: String
    
    @State private var cameraPosition: MapCameraPosition
    @State private var spanMeters: CLLocationDistance = 600
    @State private var isSharePresented: Bool = false
    
    init(coordinate: CLLocationCoordinate2D, shareText: String) {
        self.coordinate = coordinate
        self.shareText = shareText
        _cameraPosition = State(initialValue: .region(
            MKCoordinateRegion(
                center: coordinate,
                latitudinalMeters: 600,
                longitudinalMeters: 600
            )
        ))
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Map(position: $cameraPosition, interactionModes: .all) {
                Annotation("SOS", coordinate: coordinate) {
                    SOSPulsingPin()
                }
            }
            .mapControls {
                MapCompass()
                MapPitchToggle()
                MapUserLocationButton()
            }
            .ignoresSafeArea(edges: .bottom)
            
            bottomPanel
                .padding(.horizontal)
                .padding(.bottom, 10)
        }
        .navigationTitle("SOS Map")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isSharePresented = true
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
                .accessibilityLabel("Share")
            }
        }
        .sheet(isPresented: $isSharePresented) {
            ShareSheet(activityItems: [shareText])
        }
    }
    
    private var bottomPanel: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Button("Center") { centerToSOS() }
                    .buttonStyle(.bordered)
                
                Button("Open in Apple Maps") { openInAppleMaps() }
                    .buttonStyle(.borderedProminent)
            }
            
            HStack(spacing: 12) {
                Text("Zoom")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                
                Slider(value: $spanMeters, in: 200...6000, step: 100)
                    .onChange(of: spanMeters) { _, _ in
                        centerToSOS()
                    }
            }
        }
    }
    
    private func centerToSOS() {
        cameraPosition = .region(
            MKCoordinateRegion(
                center: coordinate,
                latitudinalMeters: spanMeters,
                longitudinalMeters: spanMeters
            )
        )
    }
    
    private func openInAppleMaps() {
        let lat = coordinate.latitude
        let lon = coordinate.longitude
        guard let url = URL(string: "http://maps.apple.com/?ll=\(lat),\(lon)&q=SOS") else { return }
        UIApplication.shared.open(url)
    }
}
