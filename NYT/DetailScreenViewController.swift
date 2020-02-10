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
import SkeletonView

class DetailScreenViewController: UIViewController, DetailScreenViewProtocol {
    
    var presenter: DetailScreenPresenterProtocol?
    var article: Article?
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = false
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        return webView
    }()
    
    lazy var loadingView: ArticleLoadingView = {
        let view = ArticleLoadingView(frame: self.view.frame)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setIsLoading(true)
        view.alpha = 1.0
        
        return view
    }()

    var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "share_button"), for: .normal)
        button.alpha = 1.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0.01, green: 0.51, blue: 0.56, alpha: 1.00)
        
        self.setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.loadURL()
    }
    
    func loadURL() {
        if let urlString = article?.webURL, let url = URL(string: urlString) {
            do {
                let some = try String(contentsOf: url)
                self.webView.loadHTMLString(some, baseURL: nil)
            } catch (let error) {
                print(error)
                self.setIsLoading(false)
                self.displayErrorView()
            }
        }
    }
    
    func displayErrorView() {
        let alert = UIAlertController(title: "Oops", message: "We had a problem loading that article!", preferredStyle: .alert)
        let tryAgain = UIAlertAction(title: "Try Again", style: .default) { (action) in
            self.loadURL()
        }
        let cancel = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(cancel)
        alert.addAction(tryAgain)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setConstraints() {
        self.view.addSubview(webView)
        self.view.addSubview(loadingView)
        self.view.addSubview(shareButton)
        self.view.bringSubviewToFront(shareButton)

        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
 
            loadingView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            shareButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            shareButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: view.bounds.height / 2 - 50),
            shareButton.heightAnchor.constraint(equalToConstant: 46),
            shareButton.widthAnchor.constraint(equalToConstant: 46)
        ])
        
    }
    
    func setIsLoading(_ isLoading: Bool) {
        if isLoading {
            UIView.animate(withDuration: 0.5) {
                self.loadingView.alpha = 1.0
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.loadingView.alpha = 0.0
            }
        }
    }

    @objc func shareButtonTapped() {
        if let urlString = article?.webURL {
            let uiActivityController = UIActivityViewController(activityItems: [urlString], applicationActivities: nil)
            uiActivityController.popoverPresentationController?.sourceView = self.view
            self.present(uiActivityController, animated: true, completion: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            if webView.estimatedProgress >= 0.45 {
                self.setIsLoading(false)
            }
        }
    }
    
}

extension DetailScreenViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.setIsLoading(true)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.setIsLoading(false)
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
