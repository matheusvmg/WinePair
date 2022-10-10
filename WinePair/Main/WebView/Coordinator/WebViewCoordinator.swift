//
//  WebViewCoordinator.swift
//  WinePair
//
//  Created by Matheus Góes on 28/09/22.
//

import UIKit

protocol WebViewCoordinatorProtocol: AnyObject {
    func dismissModal()
}

class WebViewCoordinator: NavigationCoordinator, WebViewCoordinatorProtocol {
    private let view = WebViewController()
    private let link: String
    
    init(navigationController: UINavigationController, link: String) {
        self.link = link
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        super.start()
        view.presenter = WebViewPresenter(view: view, coordinator: self, link: self.link)
        let navVC = UINavigationController(rootViewController: view)
        navigationController.present(navVC, animated: true)
    }
    
    func dismissModal() {
        navigationController.dismiss(animated: true)
    }
}
