//
//  CompassHeading.swift
//  MuslimPrayers
//
//  Created by Appnap WS13 on 12/17/22.
//

import Foundation
import Foundation
import Combine
import CoreLocation

class CompassHeading: NSObject, ObservableObject, CLLocationManagerDelegate {
    var objectWillChange = PassthroughSubject<Void, Never>()
    var degrees: Double = .zero {
        didSet {
            objectWillChange.send()
        }
    }
    
    private let locationManager: CLLocationManager
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        
        self.locationManager.delegate = self
        self.setup()
    }
    
    private func setup() {
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.headingAvailable() {
            self.locationManager.startUpdatingLocation()
            self.locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.degrees = -1 * newHeading.magneticHeading
    }
}


import SwiftUI

struct CompassViewUIkit: UIViewControllerRepresentable {
    typealias UIViewControllerType = CompassController
    func makeUIViewController(context: Context) -> CompassController {
        let vc = CompassController()
        // Do some configurations here if needed.
        return vc
    }
    
    func updateUIViewController(_ uiViewController: CompassController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}
