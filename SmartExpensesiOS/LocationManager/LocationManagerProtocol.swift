//
//  LocationManagerProtocol.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 09/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

protocol LocationManagerProtocol: AnyObject {
    
    func didFinishFindLocation(location: ExpenseLocation)
}
