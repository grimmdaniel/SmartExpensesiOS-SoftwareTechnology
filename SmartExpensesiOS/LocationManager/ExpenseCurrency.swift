//
//  ExpenseCurrency.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 12/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

struct ExpenseCurrency {
    
    let currency: String
    let value: Double
    let valueInUSD: Double
    
    var formattedPrice: String {
        return "\(value) \(currency)"
    }
    
    static let defaultExpenseCurrency = ExpenseCurrency(currency: "USD", value: 0.0, valueInUSD: 0.0)
}
