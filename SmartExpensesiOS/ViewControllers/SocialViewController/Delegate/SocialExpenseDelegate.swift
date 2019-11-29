//
//  SocialExpenseDelegate.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 29/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

protocol SocialExpenseDelegate: AnyObject {
    
    func didStartFetchExpense()
    func didFinishFetchExpense(expense: Expense)
    func didFailFetchExpense(error: NetworkError)
}
