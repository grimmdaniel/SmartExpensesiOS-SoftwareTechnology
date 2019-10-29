//
//  ContentLoadingCell.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 29/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class ContentLoadingCell: UITableViewCell {

    @IBOutlet weak var loadingText1View: UIView!
    @IBOutlet weak var loadingText2View: UIView!
    @IBOutlet weak var loadingImageView: UIView!
    
    static let nibName = "ContentLoadingCell"
    static let cellName = "ContentLoadingCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        initializeUIComponents()
    }
    
    private func initializeUIComponents() {
        layer.borderColor = UIColor.white.cgColor
        loadingText1View.backgroundColor = ColorTheme.loadingBackgroundColor
        loadingText2View.backgroundColor = ColorTheme.loadingBackgroundColor
        loadingImageView.backgroundColor = ColorTheme.loadingBackgroundColor
    }
    
}
