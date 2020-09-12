import UIKit

class NewInvestmentViewModel {
    
}

protocol DetailInvestmentPresenter: AnyObject {
    func showDetailInvestment(with viewModel: DetailInvestmentViewModel)
}

class NewInvestmentCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var newInvestmentViewModel: NewInvestmentViewModel
    
    required init(navigationController: UINavigationController, newInvestmentViewModel: NewInvestmentViewModel? = nil) {
        self.navigationController = navigationController
        self.newInvestmentViewModel = newInvestmentViewModel ?? NewInvestmentViewModel()
    }
    
    func start() {
        let newInvestmentViewController = NewInvestmentViewController()
        newInvestmentViewController.delegate = self
        navigationController.pushViewController(newInvestmentViewController, animated: true)
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
        print("NewInvestmentCoordinator deinit")
    }
    
}

extension NewInvestmentCoordinator: DetailInvestmentPresenter {}
