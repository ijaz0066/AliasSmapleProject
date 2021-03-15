//
//  LocationManager.swift
//  AliasSampleProject
//
//  Created by ijaz ahmad on 2021-03-15.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: class {
    
    func didUpdateLocation(coordinates: CLLocationCoordinate2D)
    func didUpdateAuthorizationStatus(status: CLAuthorizationStatus)
}

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    private var locationCoordinates = CLLocationCoordinate2D()
    
    weak var locationManagerDelegate: LocationManagerDelegate?
    
    var requestLocationAuthorizationCallback: ((CLAuthorizationStatus) -> Void)?
    var requestUpdatedLocationCallBack: ((CLLocationCoordinate2D) -> Void)?
    
    private override init() {
        super.init()
        requestAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
    }
    
    func setDelegate(locationManagerDelegate: LocationManagerDelegate?) {
        self.locationManagerDelegate = locationManagerDelegate
    }
    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func isAuthorized() -> Bool {
        switch locationManager.authorizationStatus {
        case .restricted, .denied, .notDetermined:
            return false
        default:
            return true
        }
    }
    
    func checkAuthorizationStatus() -> CLAuthorizationStatus {
        return locationManager.authorizationStatus
    }
    
    func getUserLocation() {
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        locationCoordinates = locValue
       // print("locations = \(locValue.latitude) \(locValue.longitude)")
       // self.requestUpdatedLocationCallBack?(locValue)
        self.locationManagerDelegate?.didUpdateLocation(coordinates: locValue)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        //self.requestLocationAuthorizationCallback?(manager.authorizationStatus)
        self.locationManagerDelegate?.didUpdateAuthorizationStatus(status: manager.authorizationStatus)
    }
}
