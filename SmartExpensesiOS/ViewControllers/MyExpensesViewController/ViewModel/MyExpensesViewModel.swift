//
//  MyExpensesViewModel.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 19/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

class MyExpensesViewModel {

    private var expenses = [Expense]()
    
    var numberOfSections: Int {
        return expenses.count
    }
    
    var numberOfRowsInSections: Int {
        return 1
    }
    
    var isEmptyExpenses: Bool {
        return expenses.isEmpty
    }
    
    func reloadDataSource(expenses: [Expense]) {
        self.expenses = expenses
    }
    
    func addNewExpense(expense: Expense) {
        expenses.insert(expense, at: 0)
    }
    
    func getElement(for index: Int) -> Expense {
        return expenses[index]
    }
    
    func removeElement(element: Expense) -> Int? {
        if let index = expenses.firstIndex(of: element) {
            expenses.remove(at: index)
            return index
        }
        return nil
    }
}
