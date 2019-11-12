//
//  ResponseParser.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 12/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

class ResponseParser {
    
    private init() {}
    
    static let shared = ResponseParser()
    
    func parseAllExpenses(json: [String:Any]) -> [Expense] {
        var expensesToReturn = [Expense]()
        if let expensesRaw = json["expenses"] as? [[String:Any]] {
            for expense in expensesRaw {
                if let expenseID = expense["id"] as? Int {
                    if let categoryID = expense["categoryID"] as? Int {
                        let title = expense["title"] as? String ?? "N/A"
                        let isPrivate = expense["private"] as? Bool ?? true
                        let currency = parseExpenseCurrency(json: expense)
                        let location = parseExpenseLocation(json: expense)
                        let date = expense["date"] as? String ?? "1970-01-01 00:00:01"
                        let newExpense = Expense(id: expenseID, location: location, currency: currency, categoryID: categoryID, isPrivate: isPrivate, title: title, date: date)
                        expensesToReturn.append(newExpense)
                    }
                }
            }
        }
        return expensesToReturn
    }
    
    private func parseExpenseCurrency(json: [String:Any]) -> ExpenseCurrency {
        if let currency = json["currency"] as? String {
            if let value = json["value"] as? Double {
                if let valueUSD = json["valueUSD"] as? Double {
                    return ExpenseCurrency.init(currency: currency, value: value, valueInUSD: valueUSD)
                }
            }
        }
        return ExpenseCurrency.defaultExpenseCurrency
    }
    
    private func parseExpenseLocation(json: [String:Any]) -> ExpenseLocation {
        if let latitude = json["latitude"] as? Double {
            if let longitude = json["longitude"] as? Double {
                if let address = json["address"] as? String {
                    return ExpenseLocation(latitude: latitude, longitude: longitude, address: address)
                }
            }
        }
        return ExpenseLocation.defaultLocation
    }
}
