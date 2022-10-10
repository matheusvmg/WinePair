//
//  WebViewPresenter.swift
//  WinePair
//
//  Created by Matheus Góes on 28/09/22.
//

import Foundation

protocol WebViewPresenterProtocol {
    func getURLForWebView() -> URL
    func dismissModal()
}

class WebViewPresenter: WebViewPresenterProtocol {
    let view: WebViewController
    let coordinator: WebViewCoordinatorProtocol
    private let link: String
    
    init(view: WebViewController, coordinator: WebViewCoordinatorProtocol, link: String) {
        self.view = view
        self.coordinator = coordinator
        self.link = link
    }
    
    func getURLForWebView() -> URL {
        let url = URL(string: self.link)!
        return url
    }
    
    func dismissModal() {
        coordinator.dismissModal()
    }
}
