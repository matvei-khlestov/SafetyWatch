# SafetyWatch

SafetyWatch is a demo iOS + watchOS project that implements a complete emergency SOS flow between Apple Watch and iPhone, focused on fast reaction, predictable behavior, and a clean, state-driven architecture.

<p align="center">
  <img
    src="https://github.com/user-attachments/assets/aefef67e-4003-4b3e-94d4-a87d71301bb6"
    alt="SafetyWatch mockups"
    width="100%"
  />
</p>

## Overview

The project demonstrates how an SOS signal can be triggered from Apple Watch and instantly handled on iPhone — including geolocation, map presentation, navigation, and history tracking.

The solution is designed with emergency scenarios in mind, where minimal interaction and immediate feedback are critical.

## Core Functionality

- Sending an SOS signal from watchOS  
- Signal delivery via WatchConnectivity  
- Automatic geolocation request on iPhone  
- Instant transition to MapKit with a pulsing SOS marker  
- Map interactions: zoom, centering, navigation, coordinate sharing  
- SOS history with persistent storage  
- Safe history clearing with user confirmation  
- State-driven UI with predictable behavior  
- Clean separation of responsibilities between layers  

## Architecture

- SwiftUI for both iOS and watchOS
- MVVM with a dedicated orchestration layer
- WatchConnectivity for device-to-device communication
- MapKit + CoreLocation for geolocation and navigation
- Persistent storage for SOS history
- Reusable UI components shared across platforms

## Platforms

- iOS
- watchOS

## Tech Stack

- Swift
- SwiftUI
- watchOS / WatchKit
- MapKit
- CoreLocation
- UserDefaults
- async / await
- WatchConnectivity
- MVVM Architecture
