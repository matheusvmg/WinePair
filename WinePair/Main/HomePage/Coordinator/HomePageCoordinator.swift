//
//  HomePageCoordinator.swift
//  WinePair
//
//  Created by Matheus Góes on 27/09/22.
//

import UIKit

protocol HomePageCoordinatorProtocol: AnyObject {
    func goToDetailsPage(with content: Wine, alternativeDescriptionText: String?)
}

class HomePageCoordinator: NavigationCoordinator, HomePageCoordinatorProtocol {
    private let view = HomePageViewController()
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        super.start()
        view.presenter = HomePagePresenter(view: view, coordinator: self, networkManager: NetworkManager())
        navigationController.setViewControllers([view], animated: false)
    }
    
    func goToDetailsPage(with content: Wine, alternativeDescriptionText: String?) {
        DetailsPageCoordinator(navigationController: navigationController, wineDetails: content, alternativeDescriptionText: alternativeDescriptionText).start()
    }
}
