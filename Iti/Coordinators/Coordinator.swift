import UIKit

public protocol Coordinator: class {
    
    var childCoordinator: [Coordinator] { get set }
    
    init(naviagtionController: UINavigationController)
    
    func start()
    
}
