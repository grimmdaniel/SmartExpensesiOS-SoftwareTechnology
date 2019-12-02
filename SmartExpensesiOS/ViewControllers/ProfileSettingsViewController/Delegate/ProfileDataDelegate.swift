//
//  ProfileDataDelegate.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 29/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

protocol ProfileDataDelegate: AnyObject {
    
    func didStartFetchingProfileData()
    func didFinishFetchingProfileData(data: ProfileData)
    func didFailToFetchProfileData(error: NetworkError)
}
