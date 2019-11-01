//
//  RegistrationDelegate.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 01/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

protocol RegistrationDelegate: AnyObject {
    
    func didStartRegistration()
    func didFinishRegistration(token: String,user: String)
    func didFailToRegisterUser(error: Error)
}
