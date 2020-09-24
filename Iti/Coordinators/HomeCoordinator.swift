import UIKit

protocol ListInvestmentPresenter: AnyObject {
    func showList(with viewModel: ListInvestmentsViewModel)
}

class HomeCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []


    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = false
    }
    
    func start() {
        let viewController = ViewController.instantiateFromStoryboard(.main)
        viewController.coordinator = self
        navigationController.present(viewController, animated: true, completion: nil)
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
        self.navigationController.isNavigationBarHidden = true
        print("HomeCoordinator deinit")
    }
    
    
}


extension HomeCoordinator: ListInvestmentPresenter { }
