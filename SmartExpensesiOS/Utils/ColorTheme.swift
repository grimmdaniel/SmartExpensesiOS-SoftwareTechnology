//
//  ColorTheme.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 09/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class ColorTheme {
    
    static let primaryColor: UIColor = UIColor.hexStringToUIColor(hexCode: "24AA7B")
    static let secondaryColor: UIColor = UIColor.hexStringToUIColor(hexCode: "2E2727")
    static let defaultBackgroundColor: UIColor = UIColor.hexStringToUIColor(hexCode: "D8D8D8")
    static let loadingBackgroundColor: UIColor = UIColor.hexStringToUIColor(hexCode: "DADFEC")
}

extension UIColor {
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return String(format:"#%06x", rgb)
    }
    
    static func hexStringToUIColor (hexCode: String) -> UIColor {
        var colorString:String = hexCode.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (colorString.hasPrefix("#")) {
            colorString.remove(at: colorString.startIndex)
        }
        
        if (colorString.count != 6) {
            return UIColor.gray
        }
                
        var rgbValue:UInt32 = 0
        Scanner(string: colorString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
