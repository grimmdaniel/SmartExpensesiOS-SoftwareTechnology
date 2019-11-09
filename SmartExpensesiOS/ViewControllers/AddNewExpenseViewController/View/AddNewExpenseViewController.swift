//
//  AddNewExpenseViewController.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 07/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class AddNewExpenseViewController: UIViewController, StoryboardAble {

    var closeScreenClosure: (() -> Void)?
    var newExpenseCreated: (() -> Void)?
    var locationManager: LocationManager!
    private lazy var childVC = SelectExpenseCategoryVC.instantiate()
    
    @IBOutlet weak var transparentBackgroundView: UIView!
    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var expenseNameTextField: UITextField!
    @IBOutlet weak var expensePriceTextField: UITextField!
    @IBOutlet weak var expenseCategoryTextField: UITextField!
    
    @IBOutlet weak var selectCategoryButton: UIButton!
    @IBOutlet weak var selectCategoryContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalPresentationCapturesStatusBarAppearance = true
        setUpUI()
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        setUpTextFieldBehaviour()
        locationManager.delegate = self
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    private func setUpUI() {
        transparentBackgroundView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        mainBackgroundView.layer.cornerRadius = 10.0
        selectCategoryContainerView.layer.cornerRadius = 10.0
        selectCategoryContainerView.layer.masksToBounds = true
        selectCategoryContainerView.isHidden = true
        saveButton.layer.cornerRadius = 20.0
    }
    
    private func showCategoryVC() {
        
        childVC.categorySelectedClosure = { [weak self] (categoryID) in
            self?.removeCategoryVC()
        }
        
        childVC.view.frame = selectCategoryContainerView.bounds
        selectCategoryContainerView.addSubview(childVC.view)
        addChild(childVC)
        childVC.didMove(toParent: self)
    }
    
    private func removeCategoryVC() {
        childVC.willMove(toParent: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParent()
        selectCategoryContainerView.isHidden = true
    }
    
    private func setUpTextFieldBehaviour() {
        expenseNameTextField.returnKeyType = UIReturnKeyType.next
        expensePriceTextField.returnKeyType = UIReturnKeyType.next
        expenseNameTextField.delegate = self
        expensePriceTextField.delegate = self
    }
    
    private func getDataFromTextFields() {
        var name = expenseNameTextField.text ?? "N/A"
        if name == "" { name = "N/A" }
        var amountString = expensePriceTextField.text ?? "0"
        if amountString == "" { amountString = "0" }
        print(name)
        print(amountString)
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        closeScreenClosure?()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        getDataFromTextFields()
        locationManager.getUserLocation()
//        newExpenseCreated?()
    }
    
    @IBAction func selectCategoryPressed(_ sender: UIButton) {
        selectCategoryContainerView.isHidden = false
        showCategoryVC()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension AddNewExpenseViewController: LocationManagerProtocol {
    
    func didFinishFindLocation(location: ExpenseLocation) {
        print(location)
    }
}

extension AddNewExpenseViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == expenseNameTextField {
            expensePriceTextField.becomeFirstResponder()
        } else if textField == expensePriceTextField {
            expenseNameTextField.becomeFirstResponder()
        }
        return true
    }
}
