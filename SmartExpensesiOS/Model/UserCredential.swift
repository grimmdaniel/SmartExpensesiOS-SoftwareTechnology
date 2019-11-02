//
//  UserCredential.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 01/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

struct UserCredential {
    
    let email: String
    private let password: String
    
    var encodedPassword: String {
        //TODO
        return password
    }
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
