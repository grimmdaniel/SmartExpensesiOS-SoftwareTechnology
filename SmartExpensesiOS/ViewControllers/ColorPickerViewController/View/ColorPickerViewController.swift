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
    var colorSelectedClosure: ((String) -> Void)?
    
    @IBOutlet weak var colorWheel: ColorWheel!
    @IBOutlet weak var colorView: UIButton!
    @IBOutlet weak var selectedColorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        colorView.backgroundColor = selectedColor
        colorView.isUserInteractionEnabled = false
        let ges = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(gesture:)))
        colorWheel.isUserInteractionEnabled = true
        colorWheel.addGestureRecognizer(ges)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(colorSelected))
    }
    
    @objc func colorSelected() {
        colorSelectedClosure?(self.selectedColor.toHexString())
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
