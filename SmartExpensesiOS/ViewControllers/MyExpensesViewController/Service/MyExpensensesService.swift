//
//  MyExpensensesService.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 12/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

class MyExpensensesService {
    
    weak var delegate: MyExpensesDelegate?
    weak var deletionDelegate: MyExpenseDeleteDelegate?
    private let manager = NetworkManager()
    
    func fetchAllExpenses() {
        guard let apiKey = UserDefaults.APIKEY else { return }
        let httpObject = HTTPObject(
            type: .GET, endpoint: .allExpenses, httpHeader: HTTPObject.createHeaderWithAuthentication(apiKey: apiKey), httpBody: [:]
        )
        delegate?.didStartFetchingExpenses()
        manager.performNetworkRequest(with: httpObject) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    let expenses = ResponseParser.shared.parseAllExpenses(json: json)
                    self?.delegate?.didFinishFetchingExpenses(expenses: expenses)
                case .failure(let error):
                    self?.delegate?.didFailFetchingExpenses(error: error)
                }
            }
        }
    }
    
    func deleteExpense(expense: Expense) {
        guard let apiKey = UserDefaults.APIKEY else { return }
        let httpObject = HTTPObject(
            type: .DELETE, endpoint: .deleteExpense, urlParameter: expense.id, httpHeader: HTTPObject.createHeaderWithAuthentication(apiKey: apiKey), httpBody: [:]
        )
        deletionDelegate?.didStartDeleteExpense()
        manager.performNetworkRequest(with: httpObject) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.deletionDelegate?.didFinishDeleteExpense(expense: expense)
                case .failure(let error):
                    self?.deletionDelegate?.didFailDeleteExpense(error: error)
                }
            }
        }
    }
}
