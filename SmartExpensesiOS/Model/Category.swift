//
//  Category.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 20/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

struct Category {
    
    let categories = [
        "categoryTranslationRestaurant".localized,
        "categoryTranslationTickets".localized,
        "categoryTranslationMuseum".localized,
        "categoryTranslationHotel".localized,
        "categoryTranslationCash".localized,
        "categoryTranslationShopping".localized,
        "categoryTranslationGas".localized,
        "categoryTranslationTravel".localized,
        "categoryTranslationOther".localized
    ]
    
    func getCategoryNameByIndex(index: Int) -> String {
        if index >= categories.count || index < 0 { return "categoryTranslationOther".localized }
        return categories[index]
    }
    
    func getCategoryImageByIndex(index: Int) -> UIImage {
        if index >= categories.count || index < 0 { return UIImage(named: "Others.png") ?? UIImage() }
        return UIImage(named: categories[index]) ?? UIImage()
    }
}
