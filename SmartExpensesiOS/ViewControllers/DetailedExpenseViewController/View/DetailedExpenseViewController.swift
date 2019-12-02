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
    
    enum CardState {
        case collapsed
        case expanded
    }
    
    // Variable determines the next state of the card expressing that the card starts and collapased
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    // Variable for card view controller
    var cardViewController: SlideUpVC!
    
    // Variable for effects visual effect view
    var visualEffectView: UIVisualEffectView!
    
    // Starting and end card heights will be determined later
    var endCardHeight: CGFloat = 0
    var startCardHeight: CGFloat = 0
    
    // Current visible state of the card
    var cardVisible = false

    // Empty property animator array
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted: CGFloat = 0
    
    @IBOutlet weak var detailedExpenseMapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCard()
        setUpMap()
        addAnnotation(expense: currentExpense)
        setRegion()
        self.navigationItem.title = currentExpense.title
    }
    
    func setupCard() {
        // Setup starting and ending card height
        endCardHeight = self.view.frame.height * 0.6
        startCardHeight = self.view.frame.height * 0.25
       
        // Add Visual Effects View
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)

        // Add CardViewController xib to the bottom of the screen, clipping bounds so that the corners can be rounded
        cardViewController = SlideUpVC(nibName:"SlideUpVC", bundle:nil)
        cardViewController.currentExpense = currentExpense
        self.view.addSubview(cardViewController.view)
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - startCardHeight, width: self.view.bounds.width, height: endCardHeight)
        cardViewController.view.clipsToBounds = true

        // Add tap and pan recognizers
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(recognzier:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))

        cardViewController.handleView.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleView.addGestureRecognizer(panGestureRecognizer)
    }
       
    // Handle tap gesture recognizer
    @objc func handleCardTap(recognzier:UITapGestureRecognizer) {
        switch recognzier.state {
        // Animate card when tap finishes
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
       
   // Handle pan gesture recognizer
   @objc func handleCardPan (recognizer:UIPanGestureRecognizer) {
       switch recognizer.state {
       case .began:
           // Start animation if pan begins
           startInteractiveTransition(state: nextState, duration: 0.9)
           
       case .changed:
           // Update the translation according to the percentage completed
           let translation = recognizer.translation(in: self.cardViewController.handleView)
           var fractionComplete = translation.y / endCardHeight
           fractionComplete = cardVisible ? fractionComplete : -fractionComplete
           updateInteractiveTransition(fractionCompleted: fractionComplete)
       case .ended:
           // End animation when pan ends
           continueInteractiveTransition()
       default:
           break
       }
   }
    // Animate transistion function
     func animateTransitionIfNeeded (state: CardState, duration:TimeInterval) {
         // Check if frame animator is empty
         if runningAnimations.isEmpty {
             // Create a UIViewPropertyAnimator depending on the state of the popover view
             let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                 switch state {
                 case .expanded:
                     // If expanding set popover y to the ending height and blur background
                     self.cardViewController.view.frame.origin.y = self.view.frame.height - self.endCardHeight
                     self.visualEffectView.effect = UIBlurEffect(style: .dark)

                 case .collapsed:
                     // If collapsed set popover y to the starting height and remove background blur
                     self.cardViewController.view.frame.origin.y = self.view.frame.height - self.startCardHeight
                     
                     self.visualEffectView.effect = nil
                 }
             }
             
             // Complete animation frame
             frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
             }
             
             // Start animation
             frameAnimator.startAnimation()
             
             // Append animation to running animations
             runningAnimations.append(frameAnimator)
             
             // Create UIViewPropertyAnimator to round the popover view corners depending on the state of the popover
             let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                 switch state {
                 case .expanded:
                     // If the view is expanded set the corner radius to 30
                     self.cardViewController.view.layer.cornerRadius = 30
                     
                 case .collapsed:
                     // If the view is collapsed set the corner radius to 0
                     self.cardViewController.view.layer.cornerRadius = 0
                 }
             }
             
             // Start the corner radius animation
             cornerRadiusAnimator.startAnimation()
             
             // Append animation to running animations
             runningAnimations.append(cornerRadiusAnimator)
             
         }
     }
     
     // Function to start interactive animations when view is dragged
     func startInteractiveTransition(state: CardState, duration: TimeInterval) {
         
         // If animation is empty start new animation
         if runningAnimations.isEmpty {
             animateTransitionIfNeeded(state: state, duration: duration)
         }
         
         // For each animation in runningAnimations
         for animator in runningAnimations {
             // Pause animation and update the progress to the fraction complete percentage
             animator.pauseAnimation()
             animationProgressWhenInterrupted = animator.fractionComplete
         }
     }
     
     // Funtion to update transition when view is dragged
     func updateInteractiveTransition(fractionCompleted: CGFloat) {
         // For each animation in runningAnimations
         for animator in runningAnimations {
             // Update the fraction complete value to the current progress
             animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
         }
     }
     
     // Function to continue an interactive transisiton
     func continueInteractiveTransition () {
         // For each animation in runningAnimations
         for animator in runningAnimations {
             // Continue the animation forwards or backwards
             animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
         }
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
