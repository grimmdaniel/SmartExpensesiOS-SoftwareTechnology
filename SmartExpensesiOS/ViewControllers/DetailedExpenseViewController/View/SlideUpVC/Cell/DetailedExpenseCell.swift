//
//  DetailedExpenseCell.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 28/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class DetailedExpenseCell: UITableViewCell {

    static let cellID = "DetailedExpenseCell"
    
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var valueTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
