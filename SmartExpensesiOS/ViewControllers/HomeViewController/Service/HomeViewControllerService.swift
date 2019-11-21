//
//  HomeViewControllerService.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 19/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

class HomeViewControllerService {
    
    weak var delegate: HomeDelegate?
    
    func fetchRecentExpenses(number: Int) {
        guard let apiKey = UserDefaults.APIKEY else { return }
        let httpObject = HTTPObject(
            type: .GET, endpoint: .recommendations, urlParameter: number, httpHeader: HTTPObject.createHeaderWithAuthentication(apiKey: apiKey), httpBody: [:]
        )
        delegate?.didStartFetchingRecommendations()
        NetworkManager().performNetworkRequest(with: httpObject) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    let results = ResponseParser.shared.parseHomeScreenData(json: json)
                    self?.delegate?.didFinishFetchingRecommendations(recommendations: results.0, expenses: results.1)
                case .failure(let error):
                    self?.delegate?.didFailFetchingRecommendations(error: error)
                }
            }
        }
    }
}
