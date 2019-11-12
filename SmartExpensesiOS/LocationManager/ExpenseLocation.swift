//
//  ExpenseLocation.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 09/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

struct ExpenseLocation {
    
    let latitude: Double
    let longitude: Double
    let address: String
    
    static let defaultLocation = ExpenseLocation(latitude: 47.497913, longitude: 19.040236, address: "Somewhere in the world.")
}
