import Foundation
import UIKit


//protocol NewInvestmentPresenter: AnyObject {
//    func showNewInvestment(with viewModel: InvestmentViewModel)
//}

class LoginCoordinator: Coordinator {
 
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
 
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
//        let listInvestmentViewController = LoginViewController()
        listInvestmentViewController.coordinator = self
//        navigationController.pushViewController(listInvestmentViewController, animated: true)
    }
    
    func showNewInvestment(with viewModel: InvestmentViewModel) {
        let childCoordinator = NewInvestmentCoordinator(navigationController: navigationController, newInvestmentViewModel: viewModel)
        childCoordinator.parentCoordinator = self
        add(childCoordinator: childCoordinator)
        childCoordinator.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("LoginCoordinator deinit")
    }

}

//extension ListInvestmentCoordinator: NewInvestmentPresenter, DetailInvestmentPresenter { }
