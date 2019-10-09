//
//  WelcomeImageCell.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 09/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class WelcomeImageCell: UICollectionViewCell {
    
    static let cellID = "WelcomeImageCell"
    
    @IBOutlet weak var welcomeImageView: UIImageView!
    
    override func awakeFromNib() {
        welcomeImageView.contentMode = .scaleAspectFit
        welcomeImageView.image = UIImage(named: "welcomeImage_1.png")
    }
}
