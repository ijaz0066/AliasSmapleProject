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
    
    //initilizer
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
}

//MARK:- Local Methods
//add local functions here
extension LocationManager {
    
    private func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
}

//MARK:- Public Methods
//add public functions here
extension LocationManager {
    
    func checkAuthorizationStatus() -> CLAuthorizationStatus {
        return locationManager.authorizationStatus
    }
    
    func getUserLocation() {
        locationManager.startUpdatingLocation()
    }
}

//MARK:- CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        locationCoordinates = locValue
        self.locationManagerDelegate?.didUpdateLocation(coordinates: locValue)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.locationManagerDelegate?.didUpdateAuthorizationStatus(status: manager.authorizationStatus)
    }
}
