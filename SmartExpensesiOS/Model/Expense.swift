//
//  Expense.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 24/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

struct Expense {
    
    let id: Int
    let location: ExpenseLocation
    let currency: ExpenseCurrency
    let categoryID: Int
    let isPrivate: Bool
    let title: String
    let date: Double
    
    var dateInString: String {
        return Expense.convertTimeStampToDate(from: date)
    }
    
    private static func convertTimeStampToDate(from timeStamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY. MMM d, HH:mm"
        return dateFormatter.string(from: date)
    }
}

extension Expense: Equatable {
    
    static func == (lhs: Expense, rhs: Expense) -> Bool {
        return lhs.id == rhs.id
    }
}
