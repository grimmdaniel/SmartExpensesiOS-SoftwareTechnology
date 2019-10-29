//
//  SocialViewController.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 22/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SocialViewController: UIViewController, StoryboardAble {
    
    let regionRadius: CLLocationDistance = 10000
    var locationManager = CLLocationManager()
    
    let dummyLocations = [
        CLLocationCoordinate2D(latitude: 47.510843, longitude: 19.056809),
        CLLocationCoordinate2D(latitude: 47.516612, longitude: 19.060531),
        CLLocationCoordinate2D(latitude: 47.504205, longitude: 19.061497),
        CLLocationCoordinate2D(latitude: 47.498718, longitude: 19.065756),
        CLLocationCoordinate2D(latitude: 47.486829, longitude: 19.058600),
        CLLocationCoordinate2D(latitude: 47.495840, longitude: 19.058235),
        CLLocationCoordinate2D(latitude: 47.499587, longitude: 19.047914),
        CLLocationCoordinate2D(latitude: 47.497007, longitude: 19.049684),
        CLLocationCoordinate2D(latitude: 47.493912, longitude: 19.050253),
        CLLocationCoordinate2D(latitude: 47.498834, longitude: 19.059606)
    ]
    
    @IBOutlet weak var socialMapView: MKMapView!
    @IBOutlet weak var myPositionButton: UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        title = "Social"
        tabBarItem.image = UIImage(named: "tabbar_2.png")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavbar()
        setUpMap()
        setUpLocationManager()
        addPinsToMap()
    }
    
    private func setUpMap() {
        socialMapView.showsUserLocation = true
        socialMapView.delegate = self
    }
    
    private func setUpNavbar() {
        navigationController?.navigationBar.barTintColor = ColorTheme.primaryColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func addPinsToMap() {
        for coordinate in dummyLocations {
            let marker = CustomMKAnnotation(title: "Test", subtitle: "subtitle", coordinate: coordinate)
            socialMapView.addAnnotation(marker)
        }
    }
    
    private func setUpLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            refreshUserPosition()
        }
    }
    
    private func refreshUserPosition() {
        guard let coordinate = locationManager.location?.coordinate else {return}
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        socialMapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func myPositionButtonPressed(_ sender: UIButton) {
        refreshUserPosition()
    }
}

extension SocialViewController: CLLocationManagerDelegate {}

extension SocialViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? CustomMKAnnotation {
            let identifier = "identifier"
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.image = annotation.image //add this
            annotationView.canShowCallout = true
            annotationView.calloutOffset = CGPoint(x: -5, y: 5)
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            return annotationView
        }
        return nil
    }
}
