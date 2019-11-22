//
//  ExpenseCell.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 24/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class ExpenseCell: UITableViewCell {

    @IBOutlet weak var croppedView: UIView!
    @IBOutlet weak var expenseNameLabel: UILabel!
    @IBOutlet weak var expenseCategoryLogo: UIImageView!
    @IBOutlet weak var expensePlaceLogo: UIImageView!
    @IBOutlet weak var expensePlaceLabel: UILabel!
    @IBOutlet weak var expensePriceLabel: UILabel!
    
    static let nibName = "ExpenseCell"
    static let cellName = "ExpenseCell"
    
    var currentExpense: Expense! {
        didSet {
            expenseNameLabel.text = currentExpense.title
            expensePlaceLabel.text = currentExpense.location.address
            expensePriceLabel.text = currentExpense.currency.formattedPrice
            expenseCategoryLogo.image = Category().getCategoryImageByIndex(index: currentExpense.categoryID)
        }
    }
    
    override func awakeFromNib() {
        selectionStyle = .none
        initializeUIComponents()
    }
    
    private func initializeUIComponents() {
        croppedView.layer.cornerRadius = 5.0
        croppedView.layer.borderColor = ColorTheme.primaryColor.cgColor
        croppedView.layer.borderWidth = 1.0
    }
}
