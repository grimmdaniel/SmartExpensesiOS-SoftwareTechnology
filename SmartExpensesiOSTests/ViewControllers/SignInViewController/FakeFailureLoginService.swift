//
//  FakeFailureLoginService.swift
//  SmartExpensesiOSTests
//
//  Created by Grimm Dániel on 10/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation
@testable import SmartExpensesiOS

class FakeFailureLoginService: AuthorizationService {
    
    let error: NetworkError
    
    init(error: NetworkError, delegate: AuthorizationDelegate) {
        self.error = error;
        super.init()
        self.delegate = delegate
    }
    
    override func loginUser(user: UserCredential) {
        delegate?.didFailToAuthorizeUser(error: error)
    }
  
}
