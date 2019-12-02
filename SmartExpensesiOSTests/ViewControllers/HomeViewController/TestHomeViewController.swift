//
//  TestHomeViewController.swift
//  SmartExpensesiOSTests
//
//  Created by Grimm Dániel on 02/12/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import XCTest
@testable import SmartExpensesiOS

class TestHomeViewController: XCTestCase {

    var homeViewController: HomeViewController!
    
    override func setUp() {
        homeViewController = HomeViewController.instantiate()
        homeViewController.viewModel = HomeViewModel()
        homeViewController.service = HomeViewControllerService()
        _ = homeViewController.view //to call viewDidLoad()
    }
    
    func testAllViewsAndSubviewsLoaded() {
        XCTAssertNotNil(homeViewController.mainTableView)
    }

}
