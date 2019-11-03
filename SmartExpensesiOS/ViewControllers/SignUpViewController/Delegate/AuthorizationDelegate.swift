//
//  AuthorizationDelegate.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 02/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

protocol AuthorizationDelegate: AnyObject {
    
    func didStartAuthorization()
    func didFinishAuthorization(token: String,user: String)
    func didFailToAuthorizeUser(error: NetworkError)
}
