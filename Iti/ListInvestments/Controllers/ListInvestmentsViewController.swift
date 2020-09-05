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
    
    var currentValues: [String?] = []

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupView()
        loadInvestments()
        loadCurrentValues()
    }

    // MARK: - IBActions
    @IBAction func newInvestiment(_ sender: Any) {
        self.performSegue(withIdentifier: "showForm", sender: nil)
    }

    // MARK: - Methods
    private func setupView() {
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true

        let orangeColor = UIColor(named: "MainOrange") ?? .white
        self.navigationController?.navigationBar.barTintColor = orangeColor
        
    }


    private func loadInvestments() {
        investmentManager.performFetch()
    }

    @IBAction func newInvestment(_ sender: Any) {
        self.performSegue(withIdentifier: "showForm", sender: nil)
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
    
    private func loadCurrentValues() {
        let dispatchGroup = DispatchGroup()
        for row in 0..<investmentManager.totalInvestments {
            dispatchGroup.enter()
            if let symbol = investmentManager.getInvestimentAt(IndexPath(row: row, section: 0)).active {
                ForexAPI.loadAction(withSymbol: symbol) {[weak self] (result) in
                    guard let self = self else { return }

                    switch result {
                    case .failure(let apiError):
                        self.currentValues.append(nil)
                        print(apiError.errorMessage)
                    case .success(let forex):
                        self.currentValues.append(forex.quote.price)
                    }
                    dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            print(self.currentValues)
            self.tableView.reloadData()
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
        if indexPath.row < currentValues.count, let value = currentValues[indexPath.row] {
            cell.configure(with: investment, currentValue: Double(value) ?? nil)
        } else {
            cell.configure(with: investment)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

       if editingStyle == .delete { deleteInvestment(indexPath) }

    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let title = "Editar"

        let action = UIContextualAction(style: .normal, title: title,
          handler: { (action, view, completionHandler) in
            self.performSegue(withIdentifier: "showForm", sender: indexPath)
        })

        action.backgroundColor = UIColor(named: "MainOrange")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: indexPath)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let destination = segue.destination as? DetailInvestimentViewController {
            if let indexPath = sender as? IndexPath {
                let investment = self.investmentManager.getInvestimentAt(indexPath)
                destination.investiment = investment
            }
        }
        if let destination = segue.destination as? NewInvestmentViewController {
            if let indexPath = sender as? IndexPath {
                let investment = self.investmentManager.getInvestimentAt(indexPath)
                destination.investment = investment
                destination.newInvestmentModel = NewInvestmentModel(withModel: investment)

            }
        }
        
        if let destination = segue.destination as? DetailInvestimentViewController {
           
            if let indexPath = sender as? IndexPath {
                let investment = self.investmentManager.getInvestimentAt(indexPath)
                destination.investiment = investment
            }
        }
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
