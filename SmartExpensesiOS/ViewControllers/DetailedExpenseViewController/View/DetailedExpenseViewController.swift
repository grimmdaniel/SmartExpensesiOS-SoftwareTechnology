//
//  DetailedExpenseViewController.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 28/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit
import MapKit

class DetailedExpenseViewController: UIViewController, StoryboardAble {
    
    var currentExpense: Expense!
    let regionRadius: CLLocationDistance = 10000
    
    @IBOutlet weak var detailedExpenseMapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(currentExpense.title)
        setUpMap()
        addAnnotation(expense: currentExpense)
        setRegion()
    }
    
    private func addAnnotation(expense: Expense) {
        let coordinate = CLLocationCoordinate2D(latitude: expense.location.latitude, longitude: expense.location.longitude)
        self.detailedExpenseMapView.addAnnotation(CustomMKAnnotation(id: expense.id, title: expense.title, subtitle: Category().getCategoryNameByIndex(index: expense.categoryID), coordinate: coordinate))
    }
    
    private func setRegion() {
        let coordinate = CLLocationCoordinate2D(latitude: currentExpense.location.latitude, longitude: currentExpense.location.longitude)
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        detailedExpenseMapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func setUpMap() {
        detailedExpenseMapView.showsUserLocation = true
        detailedExpenseMapView.delegate = self
    }
}

extension DetailedExpenseViewController: MKMapViewDelegate {
    
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
