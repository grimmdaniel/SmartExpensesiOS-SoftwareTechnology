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
    
    static func loginUser(with token: String) {
        UserDefaults.APIKEY = token
    }
    
    static func logOutUser() {
        UserDefaults.APIKEY = nil
    }
}
