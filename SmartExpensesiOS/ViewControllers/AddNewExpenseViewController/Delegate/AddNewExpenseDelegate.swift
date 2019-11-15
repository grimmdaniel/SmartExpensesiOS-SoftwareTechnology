//
//  AddNewExpenseDelegate.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 12/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

protocol AddNewExpensesDelegate: AnyObject {
    
    func didStartCreatingExpense()
    func didFinishCreatingExpense(expense: Expense)
    func didFailCreatingExpense(error: NetworkError)
}
