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
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupView()
        loadInvestments()
        
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
        let gradientColorTopView = UIColor.gradientColorFor(view: topView, firstColor: UIColor(named: "MainOrange")!, secondColor: UIColor(named: "MainPink")!, endPoint: CGPoint(x: 1.5, y: 0.0))
        //let gradientColorNavigation = UIColor.gradientColorFor(view: self.navigationController!.navigationBar, firstColor: UIColor(named: "MainOrange")!, secondColor: UIColor(named: "MainPink")!, endPoint: CGPoint(x: 1.5, y: 0.0))
        topView.layer.insertSublayer(gradientColorTopView, at: 0)
        //navigationController?.navigationBar.layer.insertSublayer(gradientColorNavigation, at: 0)
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
            self.performSegue(withIdentifier: "showForm", sender: indexPath)
        })
        
        action.backgroundColor = UIColor(named: "MainOrange")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? NewInvestmentViewController {
            if let indexPath = sender as? IndexPath {
                let investment = self.investmentManager.getInvestimentAt(indexPath)
                destination.investment = investment
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
    
   
