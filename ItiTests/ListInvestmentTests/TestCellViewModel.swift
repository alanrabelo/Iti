//
//  TestCellViewModel.swift
//  ItiTests
//
//  Created by Alan Rabelo Martins on 23/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import XCTest
import CoreData
@testable import Iti

class TestCellViewModel: XCTestCase {
    
    var cellViewModel: ListInvestmentsCellViewModel!
    var context: NSManagedObjectContext!

    override func setUp() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            return
        }
        context = appDelegate.persistentContainer.viewContext
        
        let model = Investment(context: context)
        model.active = "BS4"
        model.price = 15.0
        model.quantity = 2
        model.startDate = "22-12-2020"
        cellViewModel = ListInvestmentsCellViewModel(investment: model, percentage: 12)
    }
    
    func testCellViewModel() {
        XCTAssertEqual(cellViewModel.percentageValue, "12.00%")
        XCTAssertEqual(cellViewModel.active, "BS4")
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
