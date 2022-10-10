//
//  WebViewController.swift
//  WinePair
//
//  Created by Matheus Góes on 28/09/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var presenter: WebViewPresenterProtocol!
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        self.view = webView
        title = Strings.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: presenter.getURLForWebView()))
        webView.allowsBackForwardNavigationGestures = true
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.backgroundColor = Colors.blue
        let titleTextAttributed = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleTextAttributed
        let leftBarButtonItem = UIBarButtonItem(title: Strings.close, style: .done, target: self, action: #selector(didTapDoneButton))
        leftBarButtonItem.tintColor = .white
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefreshButton))
        rightBarButtonItem.tintColor = .white
        navigationItem.setLeftBarButton(leftBarButtonItem, animated: false)
        navigationItem.setRightBarButton(rightBarButtonItem, animated: false)
    }
    
    @objc private func didTapDoneButton(_ sender: UIBarButtonItem) {
        presenter.dismissModal()
    }
    
    @objc private func didTapRefreshButton(_ sender: UIBarButtonItem) {
        webView.load(URLRequest(url: presenter.getURLForWebView()))
    }
}
