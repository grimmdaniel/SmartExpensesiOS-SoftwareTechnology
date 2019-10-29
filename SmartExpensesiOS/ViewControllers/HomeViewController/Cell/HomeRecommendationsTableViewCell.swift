//
//  HomeRecommendationsTableViewCell.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 26/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class HomeRecommendationsTableViewCell: UITableViewCell {
    
    static let cellID = "HomeRecommendationsTableViewCell"
    
    @IBOutlet weak var recommendationsCollectionView: UICollectionView!
}

extension HomeRecommendationsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecommendationCollectionViewCell.cellID, for: indexPath) as? HomeRecommendationCollectionViewCell else { return UICollectionViewCell() }
        cell.recommendationImageView.image = UIImage(named: "dummy\(indexPath.item % 2).png")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height
        return CGSize(width: height * 1.4, height: height)
    }
}
