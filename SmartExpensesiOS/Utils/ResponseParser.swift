//
//  ResponseParser.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 12/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation
import MapKit

class ResponseParser {
    
    private init() {}
    
    static let shared = ResponseParser()
    
    func parseAllExpenses(json: [String:Any]) -> [Expense] {
        var expensesToReturn = [Expense]()
        if let expensesRaw = json["expenses"] as? [[String:Any]] {
            for expense in expensesRaw {
                if let newExpense = parseExpenseRaw(expense: expense) {
                    expensesToReturn.append(newExpense)
                }
            }
        }
        return expensesToReturn
    }
    func parseExpenseLocations(json: [String:Any]) -> [CustomMKAnnotation] {
        var locations = [CustomMKAnnotation]()
        let category = Category()
        if let locationsRaw = json["location"] as? [[String:Any]] {
            for locationRaw in locationsRaw {
                if let id = locationRaw["id"] as? Int {
                    if let title = locationRaw["title"] as? String {
                        if let latitude = locationRaw["latitude"] as? Double {
                            if let longitude = locationRaw["longitude"] as? Double {
                                if let categoryID = locationRaw["categoryID"] as? Int {
                                    locations.append(CustomMKAnnotation(id: id, title: title, subtitle: category.getCategoryNameByIndex(index: categoryID), coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)))
                                }
                            }
                        }
                    }
                }
            }
        }
        return locations
    }
    
    func parseHomeScreenData(json: [String:Any]) -> ([Recommendation],[Expense]) {
        var recommendations = [Recommendation]()
        var expenses = [Expense]()
        if let items = json["expenses"] as? [String:Any] {
            if let expensesRaw = items["expenses"] as? [[String:Any]] {
                for expenseRaw in expensesRaw {
                    if let newExpense = parseExpenseRaw(expense: expenseRaw) {
                        expenses.append(newExpense)
                    }
                }
            }
            
            if let recommendationsRaw = items["images"] as? [[String:Any]] {
                for recommendationRaw in recommendationsRaw {
                    if let recommendation = parseRecommendation(json: recommendationRaw) {
                        recommendations.append(recommendation)
                    }
                }
            }
        }
        return (recommendations,expenses)
    }
    
    func parseExpense(json: [String:Any]) -> Expense? {
        if let expenseRaw = json["expense"] as? [String:Any] {
            let expense = parseExpenseRaw(expense: expenseRaw)
            return expense
        }
        return nil
    }
    
    func parseExpenseRaw(expense: [String:Any]) -> Expense? {
        if let expenseID = expense["id"] as? Int {
            if let categoryID = expense["categoryID"] as? Int {
                let title = expense["title"] as? String ?? "N/A"
                let isPrivate = expense["private"] as? Bool ?? true
                let currency = parseExpenseCurrency(json: expense)
                let location = parseExpenseLocation(json: expense)
                let date = expense["date"] as? String ?? "1970-01-01 00:00:01"
                let newExpense = Expense(id: expenseID, location: location, currency: currency, categoryID: categoryID, isPrivate: isPrivate, title: title, date: date)
                return newExpense
            }
        }
        return nil
    }
    
    private func parseRecommendation(json: [String:Any]) -> Recommendation? {
        if let recommendationID = json["id"] as? Int {
            if let imageURL = json["imageUrl"] as? String {
                if let websiteURL = json["websiteUrl"] as? String {
                    return Recommendation(id: recommendationID, imagePath: imageURL, websiteURL: websiteURL)
                }
            }
        }
        return nil
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
