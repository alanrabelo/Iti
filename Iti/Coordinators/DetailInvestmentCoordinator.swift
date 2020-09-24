import UIKit

protocol HomePresenter: AnyObject {
    func showHome()
}

class DetailInvestmentCoordinator: Coordinator {

    
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var detailInvestmentViewModel: DetailInvestmentViewModel
    
    init(navigationController: UINavigationController, detailInvestmentViewModel: DetailInvestmentViewModel) {
        self.navigationController = navigationController
        self.detailInvestmentViewModel = detailInvestmentViewModel
    }
    
    func start() {
        let detailInvestmentViewController = DetailInvestimentViewController()
        detailInvestmentViewController.viewModel = detailInvestmentViewModel
        detailInvestmentViewController.coordinator = self
        navigationController.present(detailInvestmentViewController, animated: true, completion: nil)
    }
    
    func showHome() {
        let childCooordinator = HomeCoordinator(navigationController: self.navigationController)
        childCooordinator.parentCoordinator = self
        add(childCoordinator: childCooordinator)
        childCooordinator.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("DetailInvestmentCoordinator deinit")
    }
    
    
}

extension DetailInvestmentCoordinator: HomePresenter { }

