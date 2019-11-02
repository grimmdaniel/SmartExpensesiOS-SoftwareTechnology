//
//  Regex.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 01/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

struct Regex {
    
    let pattern: String

    static let email = Regex(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    static let password = Regex(pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$")
    
    static func isValidEmail(email: String) -> Bool {
        switch email {
        case Regex.email: return true
        default: return false
        }
    }
    
    static func isValidPassword(password: String) -> Bool {
        switch password {
        case Regex.password: return true
        default: return false
        }
    }
}

extension Regex {
    static func ~= (regex: Regex, text: String) -> Bool {
        return text.range(of: regex.pattern, options: .regularExpression) != nil
    }
}
