//
//  EncodeAblePass.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 22/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

protocol EncodablePass {
    
    func encodePass(password: String) -> String
}
