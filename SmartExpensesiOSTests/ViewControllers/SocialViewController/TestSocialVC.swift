//
//  TestSocialVC.swift
//  SmartExpensesiOSTests
//
//  Created by Grimm Dániel on 02/12/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import XCTest
@testable import SmartExpensesiOS

class TestSocialVC: XCTestCase {

    var socialViewController: SocialViewController!
    
    override func setUp() {
        socialViewController = SocialViewController.instantiate()
        socialViewController.viewModel = SocialViewModel()
        socialViewController.service = SocialService()
        _ = socialViewController.view
    }

    
    func testAllViewsAndSubviewsLoaded() {
        XCTAssertNotNil(socialViewController.myPositionButton)
        XCTAssertNotNil(socialViewController.socialMapView)
    }
}
