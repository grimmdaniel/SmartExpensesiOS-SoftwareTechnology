//
//  CustomMKAnnotation.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 27/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation
import MapKit

class CustomMKAnnotation: NSObject, MKAnnotation {
    
    let id: Int
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    let image: UIImage

    init(id: Int, title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.image = CustomMKAnnotation.resizeImage(image: UIImage(named: "location_pin.png")!)
        super.init()
    }
    
    private static func resizeImage(image: UIImage) -> UIImage {
        let size = CGSize(width: 50, height: 50)
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        return resizedImage ?? UIImage()
    }
}
