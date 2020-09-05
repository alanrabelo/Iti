import Foundation
import CoreData

class InvestmentManager {
    
    let context: NSManagedObjectContext
    weak var delegate: NSFetchedResultsControllerDelegate?
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController<Investment> = {
        let fetchRequest: NSFetchRequest<Investment> = Investment.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "active", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = delegate
        
        return fetchedResultsController
    }()
    
  
    func performFetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }
    
    var totalInvestments: Int {
        fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func getInvestimentAt(_ indexPath: IndexPath) -> Investment {
        fetchedResultsController.object(at: indexPath)
    }
    
    /*
        Instanciar InvestmentManager na ListInvestments
     
         lazy var investmentManager: InvestmentManager = { [weak self] in
             let investmentManager = InvestmentManager(context: context)
             investmentManager.delegate = self
             return investmentManager
         }()
     */
    
    /*
           Declarar investment na NewInvestment
        
           var investment: Investment?
     
    */
    
    /*
        Função para adicionar investimento no Form
     */
    func addNewInvestment(_ newInvestiment: NewInvestmentModel) {
        
//        if investment == nil {
//           investment = Investment(context: context)
//        }
//
//        let newInvestment = NewInvestmentModel(active: "ITAU2", quantity: 2.0, price: 500.0, startDate: "2020-09-05")
//
//       investment?.active = newInvestment.active
//       investment?.quantity = newInvestment.quantity
//       investment?.price = newInvestment.price
//       investment?.startDate = newInvestment.startDate
//
//       do {
//           try context.save()
//       } catch {
//           print("Failed saving")
//       }
        
    }
    
    /*
       Função para carregar os investimentos
    */
    func loadInvestments() {
//        investmentManager.performFetch()
    }
    
    /*
       Função para deletar investimento na tableview
    */
    func deleteInvestment(_ indexPath: IndexPath) {
        
//        let investment = investmentManager.getInvestimentAt(indexPath)
//        context.delete(investment)
//
//        do {
//            try context.save()
//        } catch {
//            print("Failed to delete investment")
//        }
    }
    
    /*
        extension NewInvestmentViewController: NSFetchedResultsControllerDelegate {

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
     */
    
}
