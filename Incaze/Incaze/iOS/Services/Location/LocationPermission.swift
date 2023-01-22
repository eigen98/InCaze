//
//  LocationPermission.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/09.
//
import Combine

import CoreLocation

class LocationPermissions: NSObject {

    typealias Status = CLAuthorizationStatus

    var shouldAutostart = true

    private let manager: CLLocationManager
    private var cancellable = Set<AnyCancellable>()
    private let statusPublisher = CurrentValueSubject<CLAuthorizationStatus, Never>(
        CLLocationManager.authorizationStatus()
    )
    private(set) var status: AnyPublisher<CLAuthorizationStatus, Never>

    //@Injected var locationService: LocationService
    var locationService = LocationService()

    init(manager: CLLocationManager = CLLocationManager()) {
        self.manager = manager
        self.status = statusPublisher.eraseToAnyPublisher()
        super.init()
        self.manager.delegate = self
        status
        .receive(on: DispatchQueue.main)
        .removeDuplicates()
        .sink { [weak self] status in
            switch status {
            case .authorizedAlways, .authorizedWhenInUse:
                print("permission status : \(status)")
                self?.locationService.ready()
            case .restricted, .denied: 
                print("permission status : \(status)")
            default:
                print("permission status : \(status)")
            }
        }
        .store(in: &cancellable)
    }

    func start() {
        _ = request()
    }

    func stop() { }

    func request() -> Future<Status, Never> {
        Future { [weak self] promise in
            guard let self = self else { return }

            
            self.status
                .sink {
                    print("request \($0)")
                    promise(.success($0)) }
                .store(in: &self.cancellable)
            self.manager.requestAlwaysAuthorization()
        }
    }
}

extension LocationPermissions: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        print("locationManager() : status")
        statusPublisher.send(status)
    }
}
