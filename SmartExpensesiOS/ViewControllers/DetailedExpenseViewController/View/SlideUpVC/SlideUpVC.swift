//
//  SlideUpVC.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 28/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class SlideUpVC: UIViewController {
    
    var currentExpense: Expense!
    var expenseData: [String]!
    var images: [UIImage]!

    @IBOutlet weak var handleView: UIView!
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cellNib = UINib.init(nibName: "DetailedExpenseCell", bundle: nil)
        dataTableView.register(cellNib, forCellReuseIdentifier: DetailedExpenseCell.cellID)
    
        expenseData = [
            Category().getCategoryNameByIndex(index: currentExpense.categoryID),
            currentExpense.currency.formattedPrice,
            currentExpense.location.address,
            currentExpense.dateInString
        ]
        
        images = [
            Category().getCategoryImageByIndex(index: currentExpense.categoryID),
            UIImage(named: "Cash.png")!,
            UIImage(named: "placeLogo.png")!,
            UIImage(named: "Date.png")!
        ]
        
        titleLabel.text = currentExpense.title
        dataTableView.delegate = self
        dataTableView.dataSource = self
        dataTableView.tableFooterView = UIView(frame: CGRect.zero)
    
    }
}

extension SlideUpVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailedExpenseCell.cellID, for: indexPath) as? DetailedExpenseCell else { return UITableViewCell() }
        cell.valueTextLabel.text = expenseData[indexPath.row]
        cell.typeImageView.image = images[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
