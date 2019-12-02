//
//  TestProfileVC.swift
//  SmartExpensesiOSTests
//
//  Created by Grimm Dániel on 02/12/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import XCTest
@testable import SmartExpensesiOS

class TestProfileVC: XCTestCase {
    
    var profileVC: ProfileSettingsViewController!

    override func setUp() {
        profileVC = ProfileSettingsViewController.instantiate()
        profileVC.service = LogoutService()
        profileVC.profileService = ProfileService()
        _ = profileVC.view
    }
    
    func testAllViewsAndSubviewsLoaded() {
        XCTAssertNotNil(profileVC.profileRingView)
        XCTAssertNotNil(profileVC.profileImageView)
        XCTAssertNotNil(profileVC.profileNameLabel)
        XCTAssertNotNil(profileVC.totalSpendingsLabel)
        XCTAssertNotNil(profileVC.settingsTableView)
    }
}
