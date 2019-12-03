//
//  ColorPickerViewController.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 01/12/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController, StoryboardAble {
    
    var selectedColor = ColorTheme.primaryColor
    var numberOfLatestSpendings: Int!
    var colorSelectedClosure: ((String) -> Void)?
    
    @IBOutlet weak var colorWheel: ColorWheel!
    @IBOutlet weak var colorView: UIButton!
    @IBOutlet weak var selectedColorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        selectedColorLabel.text = "colorSelectionScreenCurrentlySelectedColor".localized
        colorView.backgroundColor = selectedColor
        colorView.isUserInteractionEnabled = false
        let ges = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(gesture:)))
        colorWheel.isUserInteractionEnabled = true
        colorWheel.addGestureRecognizer(ges)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(colorSelected))
    }
    
    @objc func colorSelected() {
        updateUserData(data: ["color":selectedColor.toHexString(),"num_latest_spendings":numberOfLatestSpendings!])
    }
    
    @objc func handleTapGesture(gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: colorWheel)
        let selectedColor = colorWheel.colorAtPoint(point: point)
        let colorCode = selectedColor.toHexString()
        if colorCode != "#000000" {
            colorView.backgroundColor = selectedColor
            self.selectedColor = selectedColor
            print(colorCode)
        }
    }
}

extension ColorPickerViewController {
    
    func updateUserData(data: [String:Any]) {
        let manager = NetworkManager()
        guard let apiKey = UserDefaults.APIKEY else { return }
        let httpObject = HTTPObject(
            type: .PUT,
            endpoint: .updateProfile,
            httpHeader: HTTPObject.createHeaderWithAuthentication(apiKey: apiKey),
            httpBody: data
        )
        
        manager.performNetworkRequest(with: httpObject) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    print(json)
                    guard let self = self else { return }
                    self.colorSelectedClosure?(self.selectedColor.toHexString())
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
