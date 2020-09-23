//
//  LoginCoordinator.swift
//  Iti
//
//  Created by Italus Rodrigues on 23/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    init() {
        navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.isTranslucent = false
        navigationController.isNavigationBarHidden = true
    }
    
    func start() {
        let viewController = LoginViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
}
