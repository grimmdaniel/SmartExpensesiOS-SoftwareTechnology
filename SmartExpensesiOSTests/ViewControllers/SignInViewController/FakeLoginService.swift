//
//  FakeLoginService.swift
//  SmartExpensesiOSTests
//
//  Created by Grimm Dániel on 10/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation
@testable import SmartExpensesiOS

class FakeLoginService: AuthorizationDelegate {
    
    var isLoginSuccessFullCalled = false
    var isHandleErrorCalled = false
    var error: NetworkError? = nil
    
    func didStartAuthorization() {
        
    }
    
    func didFinishAuthorization(token: String, user: String) {
        isLoginSuccessFullCalled = true
    }
    
    func didFailToAuthorizeUser(error: NetworkError) {
        isHandleErrorCalled = true
        self.error = error
    }
}
