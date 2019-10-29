//
//  Extensions.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 13/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension UIView {
    func asCircle() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}

extension UserDefaults {
    
    private enum Keys {
        
        static let token = "API_KEY"
    }
    
    static var APIKEY: String? {
        
        get {
            return UserDefaults.standard.string(forKey: Keys.token)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.token)
        }
    }
    
    static var isSignedIn: Bool {
        return APIKEY != nil
    }
}
