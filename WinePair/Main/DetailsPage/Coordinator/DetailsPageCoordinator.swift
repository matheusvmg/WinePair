//
//  DetailsPageCoordinator.swift
//  WinePair
//
//  Created by Matheus Góes on 28/09/22.
//

import UIKit

protocol DetailsPageCoordinatorProtocol: AnyObject {
    func goToWebView(link: String)
    func goBack()
}

class DetailsPageCoordinator: NavigationCoordinator, DetailsPageCoordinatorProtocol {
    private let view = DetailsPageViewController()
    private let wineDetails: Wine?
    private let alternativeDescriptionText: String?
    
    init(navigationController: UINavigationController, wineDetails: Wine?, alternativeDescriptionText: String?) {
        self.wineDetails = wineDetails
        self.alternativeDescriptionText = alternativeDescriptionText
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        super.start()
        view.presenter = DetailsPagePresenter(view: view, coordinator: self, wineDetails: self.wineDetails, alternativeDescriptionText: alternativeDescriptionText)
        navigationController.pushViewController(view, animated: true)
    }
    
    func goToWebView(link: String) {
        WebViewCoordinator(navigationController: navigationController, link: link).start()
    }
    
    func goBack() {
        if let homePageViewController = navigationController.viewControllers.first(where: { $0 is HomePageViewController }) as? HomePageViewController {
            homePageViewController.setErrorOrNoWine()
        }
        navigationController.popViewController(animated: true)
    }
}
