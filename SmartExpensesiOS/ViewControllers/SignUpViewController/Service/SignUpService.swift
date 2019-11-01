//
//  SignUpService.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 01/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

class SignUpService {
    
    weak var delegate: RegistrationDelegate?
    
    func registerUser(user: UserCredential) {
        let body = ["email": user.email,"password": user.encodedPassword]
        let httpObject = HTTPObject(
            type: .POST,
            endpoint: .register,
            httpHeader: HTTPObject.httpHeader,
            httpBody: body
        )
        delegate?.didStartRegistration()
        NetworkManager().performNetworkRequest(with: httpObject) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self?.delegate?.didFailToRegisterUser(error: error)
                case .success(let json):
                    if let token = json["refresh_token"] as? String {
                        self?.delegate?.didFinishRegistration(token: token, user: user.email)
                    } else {
                        self?.delegate?.didFailToRegisterUser(error: NetworkError.JSONFormatError)
                    }
                }
            }
        }
    }
}
