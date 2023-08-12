//
//  LocationManager.swift
//  LocationDemo
//
//  Created by Sara on 8/2/2023.
//

import Foundation
import CoreLocation

enum LocationAuthorisationStatus {
    case denied, allowed, notDetermined
    
    init(status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self = .allowed
        case .denied, .restricted:
            self = .denied
        case .notDetermined:
            self = .notDetermined
        @unknown default:
            self = .notDetermined
        }
    }
}

struct Location {
    let longitude: Double
    let latitude: Double
}

final class LocationManager: NSObject {
    private(set) var locationManager = CLLocationManager()
    
    var currentLocation: Location?
    
    var authenticationStatus: LocationAuthorisationStatus {
        LocationAuthorisationStatus(status: locationManager.authorizationStatus)
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestAuthorisation() {
        if authenticationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
}


// MARK: CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocation = Location(longitude: location.coordinate.longitude, latitude: location.coordinate.latitude)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // handle the error case
        print("Error requesting location: \(error.localizedDescription)")
        
        // stop updating location if there's an error
        locationManager.stopUpdatingLocation()
    }
}
