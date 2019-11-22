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
    private let encriptor: EncodablePass = SHA256Encoder()
    
    var encodedPassword: String {
        return encriptor.encodePass(password: password)
    }
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
