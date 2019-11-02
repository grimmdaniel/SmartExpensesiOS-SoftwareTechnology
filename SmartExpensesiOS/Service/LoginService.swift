//
//  LoginService.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 26/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

class LoginService {
    
    static var isUserLoggedIn: Bool {
        return UserDefaults.isSignedIn
    }
    
    static func loginUser(token: String, user: String) {
        UserDefaults.APIKEY = token
        UserDefaults.USERNAME = user
    }
    
    static func logOutUser() {
        UserDefaults.APIKEY = nil
        UserDefaults.USERNAME = nil
    }
}
