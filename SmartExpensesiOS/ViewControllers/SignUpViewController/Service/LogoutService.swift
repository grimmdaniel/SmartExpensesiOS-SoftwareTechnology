//
//  LogoutService.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 06/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

class LogoutService {
    
    weak var delegate: LogoutDelegate?
    
    func logOutUser(apiKey: String) {
        let body: [String:String] = [:]
        let httpObject = HTTPObject(
            type: .POST,
            endpoint: .logout,
            httpHeader: HTTPObject.createHeaderWithAuthentication(apiKey: apiKey),
            httpBody: body
        )
        delegate?.didStartAuthorization()
        NetworkManager().performNetworkRequest(with: httpObject) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self?.delegate?.didFailToAuthorizeUser(error: error)
                case .success(let json):
                    print(json)
                    self?.delegate?.didFinishAuthorization()
                }
            }
        }
    }
}
