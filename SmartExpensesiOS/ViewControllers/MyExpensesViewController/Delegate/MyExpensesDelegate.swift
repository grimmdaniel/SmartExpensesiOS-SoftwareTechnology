//
//  MyExpensesDelegate.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 12/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

protocol MyExpensesDelegate: AnyObject {
    
    func didStartFetchingExpenses()
    func didFinishFetchingExpenses(expenses: [Expense])
    func didFailFetchingExpenses(error: NetworkError)
}

protocol MyExpenseDeleteDelegate: AnyObject {
    
    func didStartDeleteExpense()
    func didFinishDeleteExpense(expense: Expense)
    func didFailDeleteExpense(error: NetworkError)
}
