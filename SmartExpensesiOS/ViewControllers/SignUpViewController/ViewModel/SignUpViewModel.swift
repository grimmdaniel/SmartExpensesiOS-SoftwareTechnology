//
//  SignUpViewModel.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 01/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

class SignUpViewModel {
    
    func validateEmailAddress(email: String) -> String? {
        let trimmedEmail = email.trimmed
        if trimmedEmail == "" { return nil }
        if Regex.isValidEmail(email: trimmedEmail) { return trimmedEmail }
        return nil
    }
    
    func validatePasswords(password: String, confirmation: String) -> String? {
        if password != confirmation { return nil }
        let trimmedPassword = password.trimmed
        if trimmedPassword == "" { return nil }
        if Regex.isValidPassword(password: password) { return trimmedPassword }
        return nil
    }
}
