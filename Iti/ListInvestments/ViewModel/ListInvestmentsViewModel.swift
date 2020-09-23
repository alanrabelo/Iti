//
//  ListingViewModel.swift
//  Iti
//
//  Created by Italus Rodrigues do Prado on 12/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import Foundation
import CoreData

protocol ListInvestmentsViewModelDelegate: class {
    func didUpdateList()
}

class ListInvestmentsViewModel: NSObject {
    
    private let manager: InvestmentManager
    weak var delegate: ListInvestmentsViewModelDelegate?
    
    init(context: NSManagedObjectContext) {
        manager = InvestmentManager(context: context)
        super.init()
        manager.delegate = self
        loadInvestments()
    }
    
    var totalAmount: String {
        manager.totalAmmount.formattedPrice
    }
    
    var count: Int {
        manager.totalInvestments
    }
    
    func deleteInvestment(_ indexPath: IndexPath) {
        let investment = getInvestmentAt(indexPath)
        manager.context.delete(investment)
        
        do {
            try manager.context.save()
        } catch {
            print("Failed to delete investment")
        }
    }
    
    func activeFor(_ indexPath: IndexPath) -> String? {
        manager.getInvestimentAt(indexPath).active
    }
    
    func getInvestmentCellViewModelFor(_ indexPath: IndexPath) -> ListInvestmentsCellViewModel {
        let investment = getInvestmentAt(indexPath)
        let percentage = calculatePercentage(investment: investment)
        return ListInvestmentsCellViewModel(investment: investment, percentage: percentage)
    }
    
    func getInvestmentAt(_ indexPath: IndexPath) -> Investment {
        manager.getInvestimentAt(indexPath)
    }
    
    private func calculatePercentage(investment: Investment) -> Double {
        (investment.price * investment.quantity)/manager.totalAmmount*100
    }
    
    private func loadInvestments() {
        manager.performFetch()
    }
    
}

extension ListInvestmentsViewModel: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            print("Código para excluir o investimento da tabela")
        case .move:
            print("Código para atualizar a posição do investimento da tabela")
        case .update:
            print("Código para atualizar o investimento da tabela")
        case .insert:
            print("Código para inserir o investimento da tabela")
        @unknown default:
            print("Cenário desconhecido")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.didUpdateList()
    }
    
}
