//
//  SocialService.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 20/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

class SocialService {
    
    weak var delegate: SocialDelegate?
    weak var fetchDelegate: SocialExpenseDelegate?
    private let manager = NetworkManager()
    
    func fetchAllExpenseLocations() {
        guard let apiKey = UserDefaults.APIKEY else { return }
        let httpObject = HTTPObject(
            type: .GET,
            endpoint: .expenseLocations,
            httpHeader: HTTPObject.createHeaderWithAuthentication(apiKey: apiKey),
            httpBody: [:]
        )
        delegate?.didStartFetchingExpenseLocations()
        manager.performNetworkRequest(with: httpObject) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    let locations = ResponseParser.shared.parseExpenseLocations(json: json)
                    self?.delegate?.didFinishFetchingExpenseLocations(locations: locations)
                case .failure(let error):
                    self?.delegate?.didFailFetchingExpenseLocations(error: error)
                }
            }
        }
    }
    
    func getExpense(with id: Int) {
        guard let apiKey = UserDefaults.APIKEY else { return }
        let httpObject = HTTPObject(
            type: .GET,
            endpoint: .oneExpense,
            urlParameter: id,
            httpHeader: HTTPObject.createHeaderWithAuthentication(apiKey: apiKey),
            httpBody: [:]
        )
        fetchDelegate?.didStartFetchExpense()
        manager.performNetworkRequest(with: httpObject) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let expense = ResponseParser.shared.parseExpense(json: json) {
                        self?.fetchDelegate?.didFinishFetchExpense(expense: expense)
                    } else {
                        self?.fetchDelegate?.didFailFetchExpense(error: .JSONFormatError)
                    }
                case .failure(let error):
                    self?.delegate?.didFailFetchingExpenseLocations(error: error)
                }
            }
        }
    }
}
