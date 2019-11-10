//
//  LogoutDelegate.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 06/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

protocol LogoutDelegate: AnyObject {
    
    func didStartAuthorization()
    func didFinishAuthorization()
    func didFailToAuthorizeUser(error: NetworkError)
}
