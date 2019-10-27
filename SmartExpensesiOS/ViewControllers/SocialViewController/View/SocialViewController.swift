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
    }
    
    private func setUpMap() {
        socialMapView.showsUserLocation = true
    }
    
    private func setUpNavbar() {
        navigationController?.navigationBar.barTintColor = ColorTheme.primaryColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
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
