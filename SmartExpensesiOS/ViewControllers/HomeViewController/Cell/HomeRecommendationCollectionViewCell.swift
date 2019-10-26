//
//  HomeRecommendationCollectionViewCell.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 26/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class HomeRecommendationCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "HomeRecommendationCollectionViewCell"
    
    @IBOutlet weak var recommendationImageView: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadowView.layer.shadowOpacity = 1
        shadowView.backgroundColor = UIColor.white
        shadowView.layer.cornerRadius = 6.0
        recommendationImageView.layer.cornerRadius = 6.0
    }
}
