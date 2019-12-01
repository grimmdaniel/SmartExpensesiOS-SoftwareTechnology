//
//  ProfileService.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 29/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

class ProfileService {
    
    weak var delegate: ProfileDataDelegate?
    private let manager = NetworkManager()
    
    func fetchProfileData() {
        guard let apiKey = UserDefaults.APIKEY else { return }
        let httpObject = HTTPObject(
            type: .GET,
            endpoint: .profile,
            httpHeader: HTTPObject.createHeaderWithAuthentication(apiKey: apiKey),
            httpBody: [:]
        )
        delegate?.didStartFetchingProfileData()
        manager.performNetworkRequest(with: httpObject) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let profileData = ResponseParser.shared.parseProfileData(json: json) {
                        self?.delegate?.didFinishFetchingProfileData(data: profileData)
                    } else {
                        self?.delegate?.didFailToFetchProfileData(error: .JSONFormatError)
                    }
                case .failure(let error):
                    self?.delegate?.didFailToFetchProfileData(error: error)
                }
            }
        }
    }
}
