//
//  LocationService.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/09.
//

import Foundation
import MapKit
import Combine
import CoreLocation

class LocationService: NSObject {

    let shouldAutostart = false

    enum State {
        case idle
        case ready
        case monitoring
    }

    private let manager: CLLocationManager
    private var cancellable = Set<AnyCancellable>()

    private let speedPublisher = CurrentValueSubject<CLLocationSpeed, Never>(0)
    private(set) var speed: AnyPublisher<CLLocationSpeed, Never>

    private let locationPublisher = PassthroughSubject<CLLocation, Never>()
    private(set) var location: AnyPublisher<CLLocation, Never>

    private let statePublisher = CurrentValueSubject<State, Never>(.idle)
    private(set) var state: AnyPublisher<State, Never>

    init(manager: CLLocationManager = CLLocationManager()) {
        self.manager = manager
        self.speed = speedPublisher.eraseToAnyPublisher()
        self.state = statePublisher.eraseToAnyPublisher()
        self.location = locationPublisher.eraseToAnyPublisher()
        super.init()
        manager.delegate = self
        
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.distanceFilter = 5
        manager.showsBackgroundLocationIndicator = true
        manager.allowsBackgroundLocationUpdates = true
        manager.pausesLocationUpdatesAutomatically = true
    }

    func ready() {
        guard statePublisher.value != .ready else {
            return
        }
        statePublisher.send(.ready)
    }

    func start() {
        guard statePublisher.value != .monitoring else {
            print("statePublisher.value not monitoring")
            return
        }
        print("start")
        manager.startMonitoringSignificantLocationChanges()
        manager.startUpdatingLocation()
        manager.startUpdatingHeading()
        statePublisher.send(.monitoring)
    }

    func stop() {
        guard statePublisher.value == .monitoring else {
            return
        }
        statePublisher.send(.ready)
        manager.stopMonitoringSignificantLocationChanges()
        manager.stopUpdatingLocation()
        manager.stopUpdatingHeading()
    }
}

extension LocationService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locationManager :  \(locations)")
        //if manager.activityType == .fitness{
            locations
                .filter { $0.horizontalAccuracy >= 0 }
                .forEach {
                    locationPublisher.send($0)
                    speedPublisher.send(max(0, $0.speed))
                }
        //}
        
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager")
        debugPrint(error)
    }
}
