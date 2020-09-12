import Foundation
import UIKit


protocol NewInvestmentPresenter: AnyObject {
    func showNewInvestment(with viewModel: InvestmentViewModel)
}

class ListInvestmentCoordinator: Coordinator {
 
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var listViewModel: ListInvestmentsViewModel
    
    init(navigationController: UINavigationController, listViewModel: ListInvestmentsViewModel) {
        self.navigationController = navigationController
        self.listViewModel = listViewModel
    }
    
    func start() {
        let listInvestmentViewController = ListInvestmentsViewController()
        listInvestmentViewController.viewModel = listViewModel
        listInvestmentViewController.coordinator = self
        navigationController.pushViewController(listInvestmentViewController, animated: true)
    }
    
    func showNewInvestment(with viewModel: InvestmentViewModel) {
        let childCoordinator = NewInvestmentCoordinator(navigationController: navigationController, newInvestmentViewModel: viewModel)
        childCoordinator.parentCoordinator = self
        add(childCoordinator: childCoordinator)
        childCoordinator.start()
    }
    
    func showDetailInvestment(with viewModel: DetailInvestmentViewModel) {
        let childCoordinator = DetailInvestmentCoordinator(navigationController: navigationController, detailInvestmentViewModel: viewModel)
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

extension ListInvestmentCoordinator: NewInvestmentPresenter, DetailInvestmentPresenter { }
