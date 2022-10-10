//
//  AppCoordinator.swift
//  WinePair
//
//  Created by Matheus Góes on 27/09/22.
//

import UIKit

final class AppCoordinator: Coordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        HomePageCoordinator(navigationController: navigationController).start()
    }
}
