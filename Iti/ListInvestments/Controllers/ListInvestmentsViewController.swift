//
//  ListInvestmentsViewController.swift
//  Iti
//
//  Created by Italus Rodrigues do Prado on 05/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//
import UIKit
import CoreData

class ListInvestmentsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    // MARK: - Properties
    lazy var investmentManager: InvestmentManager = { [weak self] in
        let investmentManager = InvestmentManager(context: context)
        investmentManager.delegate = self
        return investmentManager
    }()
    
    let label: UILabel = {
       let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 22))
        label.text = "Sem ações cadastradas"
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupView()
        
        ForexAPI.loadAction(withSymbol: "PETR4") {[weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .failure(let apiError):
                print("Falha")
                print(apiError.errorMessage)
            case .success(let forex):
                print(forex.quote.priceFormatted)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - IBActions
    
    // MARK: - Methods
    private func setupView() {
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true
        
        let firstColor = UIColor(named: "MainOrange") ?? .white
        let secondColor = UIColor(named: "MainPink") ?? .white
        
        topView.addGradientSublayer(firstColor: firstColor, secondColor: secondColor, endPoint: CGPoint(x: 1.5, y: 0.0))
        self.navigationController?.navigationBar.addGradientSublayer(firstColor: firstColor, secondColor: secondColor, endPoint: CGPoint(x: 1.5, y: 0.0))
    }
    

    private func loadInvestments() {
        investmentManager.performFetch()
    }
    
    private func deleteInvestment(_ indexPath: IndexPath) {
        
        let investment = investmentManager.getInvestimentAt(indexPath)
        context.delete(investment)
        
        do {
            try context.save()
        } catch {
            print("Failed to delete investment")
        }
    }
}

extension ListInvestmentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = investmentManager.totalInvestments == 0 ? label : nil
        return investmentManager.totalInvestments
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListInvestmentsTableViewCell", for: indexPath) as? ListInvestmentsTableViewCell else {
            return UITableViewCell()
        }
        
        let investment = investmentManager.getInvestimentAt(indexPath)
        cell.configure(with: investment)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
       if editingStyle == .delete { deleteInvestment(indexPath) }
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let title = "Editar"

        let action = UIContextualAction(style: .normal, title: title,
          handler: { (action, view, completionHandler) in
        })
        
        action.backgroundColor = UIColor(named: "MainOrange")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
}



extension ListInvestmentsViewController: NSFetchedResultsControllerDelegate {

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
       tableView.reloadData()
   }
}
    
   
