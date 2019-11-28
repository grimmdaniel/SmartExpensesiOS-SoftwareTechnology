//
//  Extensions.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 13/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension UIView {
    func asCircle() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}

extension UITableView {
    
    func showEmptyTableViewMessage(message: String) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.bounds.size.width, height: self.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = ColorTheme.secondaryColor
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
}

extension UIImage {
    
    func resizeImage(newWidth: CGFloat) -> UIImage {

        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage ?? self
    }
    
    func encodeImageToBase64() -> String {
        let imageData: NSData = NSData(data: self.pngData()!)
        let strBase64Image = imageData.base64EncodedString(options: .lineLength64Characters)
        return strBase64Image
    }
}

extension UIViewController {
    
    func showErrorPopUp(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

public extension UserDefaults {
    
    private enum Keys {
        
        static let token = "API_KEY"
        static let userName = "USER_EMAIL"
        static let numberOfLatestSpendings = "NUMBER_OF_LATEST_SPENDINGS"
    }
    
    static var APIKEY: String? {
        
        get {
            return UserDefaults.standard.string(forKey: Keys.token)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.token)
        }
    }
    
    static var USERNAME: String? {
        
        get {
            return UserDefaults.standard.string(forKey: Keys.userName)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.userName)
        }
    }
    
    static var numberOfLatestSpendings: Int {
        get {
            let number = UserDefaults.standard.integer(forKey: Keys.numberOfLatestSpendings)
            if number <= 10 && number >= 5 { return number }
            return 5
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.numberOfLatestSpendings)
        }
    }
    
    static var isSignedIn: Bool {
        return APIKEY != nil
    }
}
