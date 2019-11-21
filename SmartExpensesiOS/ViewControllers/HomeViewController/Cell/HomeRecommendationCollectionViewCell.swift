//
//  HomeRecommendationCollectionViewCell.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 26/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit
import SDWebImage

class HomeRecommendationCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "HomeRecommendationCollectionViewCell"
    
    @IBOutlet weak var recommendationImageView: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    
    var currentRecommendation: Recommendation! {
        didSet {
            if let url = URL(string: currentRecommendation.imagePath) {
                recommendationImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
            } else {
                recommendationImageView.image = UIImage(named: "placeholder.png")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.layer.shadowColor = UIColor.darkGray.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadowView.layer.shadowOpacity = 1
        shadowView.backgroundColor = UIColor.white
        shadowView.layer.cornerRadius = 6.0
        recommendationImageView.layer.cornerRadius = 6.0
    }
}
