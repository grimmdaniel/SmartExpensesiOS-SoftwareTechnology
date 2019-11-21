//
//  EndPoints.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 01/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

enum EndPoints: String {
    
    case register = "/register"
    case login = "/login"
    case logout = "/logout"
    case allExpenses = "/expense/all"
    case newExpense = "/expense/add"
    case recommendations = "/expense/recent"
    case deleteExpense = "/expense/delete"
    case expenseLocations = "/expense/get-locations"
}
