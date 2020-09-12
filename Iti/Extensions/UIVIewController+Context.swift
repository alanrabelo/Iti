import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        }
        return appDelegate.persistentContainer.viewContext
        
    }
}

extension UIViewController {
    
    static func instantiateFromStoryboard(_ storyboard: UIStoryboard) -> Self {
        let name = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: name) as! Self
    }
}

extension UIStoryboard {
    static let main = UIStoryboard(name: "Main", bundle: nil)
}
