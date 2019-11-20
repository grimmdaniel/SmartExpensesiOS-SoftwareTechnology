//
//  SocialDelegate.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 20/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

protocol SocialDelegate: AnyObject {
    
    func didStartFetchingExpenseLocations()
    func didFinishFetchingExpenseLocations(locations: [CustomMKAnnotation])
    func didFailFetchingExpenseLocations(error: NetworkError)
}
