//
//  TestMyExpensesVC.swift
//  SmartExpensesiOSTests
//
//  Created by Grimm Dániel on 02/12/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import XCTest
@testable import SmartExpensesiOS

class TestMyExpensesVC: XCTestCase {
    
    var myExpensesViewController: MyExpensesViewController!

    override func setUp() {
        myExpensesViewController = MyExpensesViewController.instantiate()
        myExpensesViewController.service = MyExpensensesService()
        myExpensesViewController.viewModel = MyExpensesViewModel()
        _ = myExpensesViewController.view
    }
    
    func testAllViewsAndSubviewsLoaded() {
        XCTAssertNotNil(myExpensesViewController.myExpensesTableView)
    }
}
