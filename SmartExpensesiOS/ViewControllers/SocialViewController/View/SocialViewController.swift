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
    var activityIndicator = UIActivityIndicatorView()
    var openDetailedViewClosure: ((Expense) -> Void)?
    var viewModel: SocialViewModel!
    var service: SocialService!
    
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
        setUpActivityIndicator()
        service.delegate = self
        service.fetchDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        service.fetchAllExpenseLocations()
    }
    
    private func setUpMap() {
        socialMapView.showsUserLocation = true
        socialMapView.delegate = self
    }
    
    @objc func refreshMap() {
        service.fetchAllExpenseLocations()
    }
    
    private func setUpNavbar() {
        navigationController?.navigationBar.barTintColor = ColorTheme.primaryColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshMap))
    }
    
    private func addPinsToMap() {
        let allAnnotations = self.socialMapView.annotations
        self.socialMapView.removeAnnotations(allAnnotations)
        self.socialMapView.addAnnotations(viewModel.expenseCoordinates)
    }
    
    private func setUpActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        self.view.addSubview(activityIndicator)
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

extension SocialViewController: SocialExpenseDelegate {
    
    func didStartFetchExpense() {
        activityIndicator.startAnimating()
    }
    
    func didFinishFetchExpense(expense: Expense) {
        activityIndicator.stopAnimating()
        openDetailedViewClosure?(expense)
    }
    
    func didFailFetchExpense(error: NetworkError) {
        activityIndicator.stopAnimating()
    }
}

extension SocialViewController: SocialDelegate {
    
    func didStartFetchingExpenseLocations() {
        activityIndicator.startAnimating()
    }
    
    func didFinishFetchingExpenseLocations(locations: [CustomMKAnnotation]) {
        viewModel.expenseCoordinates = locations
        activityIndicator.stopAnimating()
        addPinsToMap()
    }
    
    func didFailFetchingExpenseLocations(error: NetworkError) {
        activityIndicator.stopAnimating()
    }
}

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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? CustomMKAnnotation {
            let id = annotation.id
            service.getExpense(with: id)
        }
    }
}
