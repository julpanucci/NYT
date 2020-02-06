//
//  DetailScreenViewController.swift
//  NYT
//
//  Created Julian Panucci on 2/4/20.
//  Copyright © 2020 Panucci. All rights reserved.
//
//

import UIKit
import WebKit

class DetailScreenViewController: UIViewController, DetailScreenViewProtocol {

	var presenter: DetailScreenPresenterProtocol?
    var article: Article?
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = false
        webView.uiDelegate = self
        webView.navigationDelegate = self
        return webView
    }()

	override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .green
        
        self.loadURL()
        
        self.setConstraints()
    }
    
    func loadURL() {
        if let urlString = article?.webURL, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }
    
    func setConstraints() {
        self.view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func setIsLoading(_ isLoading: Bool) {
        if isLoading {
            print("is loading...")
        } else {
            print("Stopped loading")
        }
    }

}

extension DetailScreenViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.setIsLoading(true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.setIsLoading(false)
    }
}

extension DetailScreenViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
}
