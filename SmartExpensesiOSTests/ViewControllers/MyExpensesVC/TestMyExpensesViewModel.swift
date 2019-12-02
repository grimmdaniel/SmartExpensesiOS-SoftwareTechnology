//
//  TestMyExpensesViewModel.swift
//  SmartExpensesiOSTests
//
//  Created by Grimm Dániel on 02/12/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import XCTest
@testable import SmartExpensesiOS

class TestMyExpensesViewModel: XCTestCase {
    
    var viewModel: MyExpensesViewModel!

    override func setUp() {
        
        viewModel = MyExpensesViewModel()
    }

    private func fillUpDataSource() {
        
        let expenses = [
            Expense(id: 0, location: ExpenseLocation(latitude: 0, longitude: 0, address: ""), currency: ExpenseCurrency(currency: "HUF", value: 100, valueInUSD: 0.3), categoryID: 1, isPrivate: true, title: "", date: 0.0),
            Expense(id: 1, location: ExpenseLocation(latitude: 0, longitude: 0, address: ""), currency: ExpenseCurrency(currency: "HUF", value: 100, valueInUSD: 0.3), categoryID: 1, isPrivate: true, title: "", date: 0.0),
            Expense(id: 2, location: ExpenseLocation(latitude: 0, longitude: 0, address: ""), currency: ExpenseCurrency(currency: "HUF", value: 100, valueInUSD: 0.3), categoryID: 1, isPrivate: true, title: "", date: 0.0)
        ]
     
        viewModel.reloadDataSource(expenses: expenses)
    }
    
    func testEmptyDataSource() {
        XCTAssertEqual(viewModel.isEmptyExpenses, true)
        XCTAssertEqual(viewModel.numberOfSections, 0)
        XCTAssertEqual(viewModel.numberOfRowsInSections, 1)
    }
    
    func testFilledUpDataSource() {
        fillUpDataSource()
        XCTAssertEqual(viewModel.numberOfSections, 3)
        XCTAssertEqual(viewModel.numberOfRowsInSections, 1)
    }
    
    func testNewExpenseAddition() {
        fillUpDataSource()
        let newExpense = Expense(id: 3, location: ExpenseLocation(latitude: 0, longitude: 0, address: ""), currency: ExpenseCurrency(currency: "HUF", value: 100, valueInUSD: 0.3), categoryID: 1, isPrivate: true, title: "", date: 0.0)
        viewModel.addNewExpense(expense: newExpense)
        XCTAssertEqual(viewModel.numberOfSections, 4)
        XCTAssertEqual(viewModel.numberOfRowsInSections, 1)
    }
    
    func testRemoveExpense() {
        fillUpDataSource()
        let expenseToRemove = Expense(id: 2, location: ExpenseLocation(latitude: 0, longitude: 0, address: ""), currency: ExpenseCurrency(currency: "HUF", value: 100, valueInUSD: 0.3), categoryID: 1, isPrivate: true, title: "", date: 0.0)
        let result = viewModel.removeElement(element: expenseToRemove)
        XCTAssertEqual(viewModel.numberOfSections, 2)
        XCTAssertNotNil(result)
    }
    
}
