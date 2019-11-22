//
//  SignInViewModel.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 02/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

class SignInViewModel {
    
    private let encriptor: EncodablePass = SHA256Encoder()
    
    func validateEmailAddress(email: String) -> String? {
        let trimmedEmail = email.trimmed
        if trimmedEmail == "" { return nil }
        if Regex.isValidEmail(email: trimmedEmail) { return trimmedEmail }
        return nil
    }
    
    func validatePasswords(password: String) -> String? {
        let trimmedPassword = password.trimmed
        if trimmedPassword == "" { return nil }
        if Regex.isValidPassword(password: password) { return trimmedPassword }
        return nil
    }
    
    func encryptPass(pass: String) -> String {
        return encriptor.encodePass(password: pass)
    }
}
