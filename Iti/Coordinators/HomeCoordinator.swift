import UIKit

class ListInvestmentViewModel {
    
}

protocol ListInvestmentPresenter: AnyObject {
    func showList(with viewModel: ListInvestmentViewModel)
}

class HomeCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeViewController = ViewController()
//        homeViewController.delegate = self
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func showList(with viewModel: ListInvestmentViewModel) {
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
