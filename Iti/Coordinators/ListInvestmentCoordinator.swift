import Foundation
import UIKit

protocol NewInvestmentPresenter: AnyObject {
    func showNewInvestment(with viewModel: NewInvestmentViewModel)
}

class ListInvestmentCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var viewModel: ListInvestmentViewModel
    
    required init(navigationController: UINavigationController, viewModel: ListInvestmentViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        let listInvestmentViewController = ListInvestmentsViewController()
        listInvestmentViewController.delegate = self
        navigationController.pushViewController(listInvestmentViewController, animated: true)
    }
    
    func showNewInvestment(with viewModel: NewInvestmentViewModel) {
        let childCoordinator = NewInvestmentCoordinator(navigationController: navigationController, newInvestmentViewModel: viewModel)
        childCoordinator.parentCoordinator = self
        add(childCoordinator: childCoordinator)
        childCoordinator.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("ListInvestmentCoordinator deinit")
    }

}

extension ListInvestmentCoordinator: NewInvestmentPresenter { }
