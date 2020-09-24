//
//  NewInvestmentTests.swift
//  ItiTests
//
//  Created by Alan Rabelo Martins on 23/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import XCTest
import CoreData
@testable import Iti

class NewInvestmentTests: XCTestCase {
    
    var viewModel: InvestmentViewModel!
    var context: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            return
        }
        context = appDelegate.persistentContainer.viewContext
        setupNewInvestmentViewModel()
    }
    
    func setupNewInvestmentViewModel() {
        let model = Investment(context: context)
        model.active = "ITS4"
        model.price = 35.00
        model.quantity = 15
        model.startDate = "31-12-2020"
        viewModel = InvestmentViewModel(withModel: model, in: context)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testViewModel() throws {
        XCTAssertEqual(viewModel.name, "ITS4")
        XCTAssertEqual(viewModel.price, "R$ 35,00")
        XCTAssertEqual(viewModel.quantity, "15")
        XCTAssertEqual(viewModel.purchaseDate, "23/09/2020")
    }

}
