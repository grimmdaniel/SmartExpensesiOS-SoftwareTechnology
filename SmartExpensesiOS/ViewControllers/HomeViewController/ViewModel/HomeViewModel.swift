//
//  HomeViewModel.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 19/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    private var recommendations = [Recommendation]()
    private var expenses = [Expense]()
    
    var numberOfRowsInSection: Int {
        return 1
    }
    
    var numberOfSections: Int {
        return 1 + expenses.count
    }
    
    var isExpensesEmpty: Bool {
        return expenses.isEmpty
    }
    
    func getRecommendations() -> [Recommendation] {
        return recommendations
    }
    
    func getExpense(for index: Int) -> Expense {
        return expenses[index]
    }
    
    func refreshDataSource(recommendations: [Recommendation], expenses: [Expense]) {
        self.recommendations = recommendations
        self.expenses = expenses
    }
}
