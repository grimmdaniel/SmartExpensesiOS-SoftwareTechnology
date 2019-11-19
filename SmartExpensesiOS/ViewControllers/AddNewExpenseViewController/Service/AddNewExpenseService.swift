//
//  AddNewExpenseService.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 12/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

class AddNewExpenseService {
    
    weak var delegate: AddNewExpensesDelegate?
    
    func createNewExpense(from json: [String:Any]) {
        guard let apiKey = UserDefaults.APIKEY else { return }
        let httpObject = HTTPObject(
            type: .POST,
            endpoint: .newExpense,
            httpHeader: HTTPObject.createHeaderWithAuthentication(apiKey: apiKey),
            httpBody: json
        )
        delegate?.didStartCreatingExpense()
        NetworkManager().performNetworkRequest(with: httpObject) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let expense = ResponseParser.shared.parseExpense(json: json) {
                        self?.delegate?.didFinishCreatingExpense(expense: expense)
                    } else {
                        self?.delegate?.didFailCreatingExpense(error: NetworkError.responseError)
                    }
                case .failure(let error):
                    self?.delegate?.didFailCreatingExpense(error: error)
                }
            }
        }
    }
}
