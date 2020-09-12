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
       navigationController.navigationBar.prefersLargeTitles = true
       navigationController.navigationBar.tintColor = UIColor(named: "main")
    }
    
    func start() {
        let homeViewController = ViewController()
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func showList(with viewModel: ListInvestmentsViewModel) {
        let childCoordinator = ListInvestmentCoordinator(navigationController: navigationController, listViewModel: viewModel)
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
