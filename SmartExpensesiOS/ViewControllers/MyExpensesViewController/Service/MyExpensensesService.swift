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
    
    func fetchAllExpenses() {
        guard let apiKey = UserDefaults.APIKEY else { return }
        let httpObject = HTTPObject(
            type: .GET, endpoint: .allExpenses, httpHeader: HTTPObject.createHeaderWithAuthentication(apiKey: apiKey), httpBody: [:]
        )
        delegate?.didStartFetchingExpenses()
        NetworkManager().performNetworkRequest(with: httpObject) { [weak self] (result) in
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
}
