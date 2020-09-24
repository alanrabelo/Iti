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

class TestListInvestmentsViewModel: XCTestCase {
    
    var viewModel: ListInvestmentsViewModel!
    var context: NSManagedObjectContext!

    override func setUp() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            return
        }
        context = appDelegate.persistentContainer.viewContext
    }
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
    func testEmptyList() {
        
        deleteAllData("Investment")
        viewModel = ListInvestmentsViewModel(context: context)
        
        XCTAssertEqual(viewModel.count, 0)
        
        let model = Investment(context: context)
        model.active = "BS4"
        model.price = 15.0
        model.quantity = 2
        model.startDate = "22-12-2020"
        let newInvestmentViewModel = InvestmentViewModel(withModel: model, in: context)
        newInvestmentViewModel.save()
        XCTAssertEqual(viewModel.count, 1)
        
        viewModel.deleteInvestment(IndexPath(row: 0, section: 0))
        XCTAssertEqual(viewModel.count, 0)

    }
    
    func testCellViewModel() {
        let model = Investment(context: context)
        model.active = "BS4"
        model.price = 15.0
        model.quantity = 2
        model.startDate = "22-12-2020"
        
        let cellViewModel = ListInvestmentsCellViewModel(investment: model, percentage: 12)
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
