//
//  AddNewExpenseViewModel.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 10/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

class AddNewExpenseViewModel {
    
    var currentlySelectedCategory: CategorySelection?
    var currentData: ExpenseMeta?
    var currentLocation: ExpenseLocation?
    
    func generateJSON() -> [String:Any]? {
        guard let category = currentlySelectedCategory, let data = currentData, let location = currentLocation else { return nil }
        return [
            "title" : data.name,
            "private" : false,
            "currency" : "HUF",
            "value" : data.value,
            "latitude" : location.latitude,
            "longitude" : location.longitude,
            "address" : location.address,
            "categoryID" : category.categoryID,
            "date" : round(Date().timeIntervalSince1970)
        ]
    }
}

typealias ExpenseMeta = (name: String, value: Int)
