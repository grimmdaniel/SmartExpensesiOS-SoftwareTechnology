//
//  AnimateAbleVC.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 29/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

protocol AnimatableVC {
    
    func startAnimation()
    func stopAnimation()
}

extension AnimatableVC where Self: UIViewController {
    
    func startAnimation() {
        for animateView in getSubViewsForAnimate() {
            animateView.clipsToBounds = true
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.withAlphaComponent(0.8).cgColor, UIColor.clear.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.7, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.8)
            gradientLayer.frame = animateView.bounds
            animateView.layer.mask = gradientLayer
            
            let animation = CABasicAnimation(keyPath: "transform.translation.x")
            animation.duration = 1.5
            animation.fromValue = -animateView.frame.size.width
            animation.toValue = animateView.frame.size.width
            animation.repeatCount = .infinity
            
            gradientLayer.add(animation, forKey: "")
        }
    }
    
    func stopAnimation() {
        for animateView in getSubViewsForAnimate() {
            animateView.layer.removeAllAnimations()
            animateView.layer.mask = nil
        }
    }
    
    private func getSubViewsForAnimate() -> [UIView] {
        var objectsToReturn: [UIView] = []
        for objView in view.subviewsRecursive() {
            objectsToReturn.append(objView)
        }
        return objectsToReturn.filter({ (object) -> Bool in
            object.shimmerAnimation
        })
    }
}
