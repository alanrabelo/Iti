import UIKit

protocol ListInvestmentPresenter: AnyObject {
    func showList(with viewModel: ListInvestmentsViewModel)
}

class HomeCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []


    init() {
       navigationController = UINavigationController()
       navigationController.navigationBar.prefersLargeTitles = false
       navigationController.navigationBar.tintColor = UIColor(named: "main")
        navigationController.navigationBar.isTranslucent = false
    }
    
    func start() {
        let viewController = ViewController.instantiateFromStoryboard(.main)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func showList(with viewModel: ListInvestmentsViewModel) {
        let childCoordinator = ListInvestmentCoordinator(navigationController: navigationController)
        childCoordinator.parentCoordinator = self
        add(childCoordinator: childCoordinator)
        childCoordinator.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("HomeCoordinator deinit")
    }
    
    
}


extension HomeCoordinator: ListInvestmentPresenter { }
