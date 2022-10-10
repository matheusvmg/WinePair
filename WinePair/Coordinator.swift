//
//  Coordinator.swift
//  WinePair
//
//  Created by Matheus Góes on 27/09/22.
//

import UIKit

protocol Coordinator {
    func start()
}

class NavigationCoordinator: NSObject, Coordinator {
    var navigationBarHidden: Bool { return true }
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.setNavigationBarHidden(navigationBarHidden, animated: false)
    }

    func finish(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
}
