//
//  HomeDelegate.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 19/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

protocol HomeDelegate: AnyObject {
    
    func didStartFetchingRecommendations()
    func didFinishFetchingRecommendations(recommendations: [Recommendation] ,expenses: [Expense])
    func didFailFetchingRecommendations(error: NetworkError)
}
