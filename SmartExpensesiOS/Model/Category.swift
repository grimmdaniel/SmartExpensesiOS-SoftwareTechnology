//
//  Category.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 20/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

struct Category {
    
    let categories = ["Restaurant","Tickets","Museum","Hotel","Cash","Shopping","Gas","Travel","Other"]
    
    func getCategoryNameByIndex(index: Int) -> String {
        if index >= categories.count || index < 0 { return "Others" }
        return categories[index]
    }
    
    func getCategoryImageByIndex(index: Int) -> UIImage {
        if index >= categories.count || index < 0 { return UIImage(named: "Others.png") ?? UIImage() }
        return UIImage(named: categories[index]) ?? UIImage()
    }
}
