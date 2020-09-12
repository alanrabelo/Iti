import UIKit

// @TODO excluir, pois foi criada apenas para teste
class DetailInvestmentViewModel {
    
}

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
//        detailInvestmentViewController.viewModel = detailInvestmentViewController
        detailInvestmentViewController.coordinator = self
        navigationController.pushViewController(detailInvestmentViewController, animated: true)
    }
    
    func showHome() {
        let childCooordinator = HomeCoordinator()
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
