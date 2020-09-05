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
    
    var totalAmmount: Double {
        
        var sum = 0.0
        fetchedResultsController.fetchedObjects?.forEach({ (investment) in
            sum += investment.price * investment.quantity
        })
        return sum
    }
    
    func getInvestimentAt(_ indexPath: IndexPath) -> Investment {
        fetchedResultsController.object(at: indexPath)
    }
    

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
    

    
   
}

