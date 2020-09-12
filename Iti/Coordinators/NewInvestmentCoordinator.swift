import UIKit

// @TODO excluir, pois foi criada apenas para teste
class NewInvestmentViewModel {
    
}

protocol DetailInvestmentPresenter: AnyObject {
    func showDetailInvestment(with viewModel: DetailInvestmentViewModel)
}

class NewInvestmentCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var newInvestmentViewModel: InvestmentViewModel
    
    init(navigationController: UINavigationController, newInvestmentViewModel: InvestmentViewModel? = nil) {
        self.navigationController = navigationController
        self.newInvestmentViewModel = newInvestmentViewModel ?? InvestmentViewModel(in: navigationController.context)
    }
    
    func start() {
        let newInvestmentViewController = NewInvestmentViewController()
        newInvestmentViewController.viewModel = newInvestmentViewModel
        newInvestmentViewController.coordinator = self
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
