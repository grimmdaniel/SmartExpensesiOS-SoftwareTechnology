//
//  WelcomeViewController.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 09/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, StoryboardAble {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var dontHaveAccountLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var nameLabel1: UILabel!
    @IBOutlet weak var nameLabel2: UILabel!
    
    @IBOutlet weak var welcomeCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let textsToShow = [
        ("Follow expenses","from anywhere"),
        ("Find cheap places","in seconds"),
        ("Share expenses","with anyone")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        welcomeCollectionView.delegate = self
        welcomeCollectionView.dataSource = self
        signInButton.layer.cornerRadius = 6.0
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
    
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
    
    }
}

extension WelcomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WelcomeImageCell.cellID, for: indexPath) as? WelcomeImageCell else { return UICollectionViewCell() }
        cell.welcomeImageView.image = UIImage(named:"welcomeImage_\(indexPath.item + 1).png")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left:  0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        changeUI(for: index)
    }
    
    private func changeUI(for index: Int) {
        pageControl.currentPage = index
        nameLabel1.text = textsToShow[index].0
        nameLabel2.text = textsToShow[index].1
    }
}
