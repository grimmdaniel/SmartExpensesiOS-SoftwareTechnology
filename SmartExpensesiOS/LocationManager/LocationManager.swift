//
//  LocationManager.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 08/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager {
    
    let manager: CLLocationManager
    let defaultLocation = CLLocationCoordinate2D(latitude: 47.497913, longitude: 19.040236)
    weak var delegate: LocationManagerProtocol?
    
    init() {
        manager = CLLocationManager()
    }
    
    func getUserLocation() {
        let location = manager.location ?? CLLocation(latitude: defaultLocation.latitude, longitude: defaultLocation.longitude)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                self?.delegate?.didFinishFindLocation(location: ExpenseLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, address: self?.convertPlacemarkToReadable(placemark: firstLocation) ?? "N/A"))
            } else {
                print("Could not get location data, reverting to default...")
                self?.delegate?.didFinishFindLocation(location: ExpenseLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, address: "Somewhere in the world"))
            }
        }
    }
    
    private func convertPlacemarkToReadable(placemark: CLPlacemark?) -> String {
        guard let place = placemark else { return "N/A" }
        let country = place.country ?? ""
        let city = (place.postalCode ?? "") + " " + (place.locality ?? "")
        let address = (place.thoroughfare ?? "") + " " + (place.subThoroughfare ?? "")
        return country + " " + city + " " + address
    }
}
