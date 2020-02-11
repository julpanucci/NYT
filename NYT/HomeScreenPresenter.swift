//
//  HomeScreenPresenter.swift
//  NYT
//
//  Created Julian Panucci on 2/4/20.
//  Copyright © 2020 Panucci. All rights reserved.
//
//

import UIKit

class HomeScreenPresenter: HomeScreenPresenterProtocol {
    
    weak var view: HomeScreenViewProtocol?
    var interactor: HomeScreenInteractorProtocol?
    let router: HomeScreenRouterProtocol
    
    var reachabilityService = ReachabilityService.shared
    
    init(interface: HomeScreenViewProtocol, interactor: HomeScreenInteractorProtocol?, router: HomeScreenRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    
    func getArticles(searchText: String, page: Int) {
        if page == 0 && reachabilityService.connectionIsUnavailable() {
            self.view?.displayError(title: "Connection error", message: "You are not connected to the internet. Connect and try again!")
        } else {
            self.interactor?.getArticles(searchText: searchText, page: page)
            DispatchQueue.main.async {
                if page == 0 {
                    self.view?.setIsLoading(true)
                }
            }
        }
    }
    
    func onArticlesLoaded(articles: [Article]) {
        DispatchQueue.main.async {
            self.view?.setIsLoading(false)
            self.view?.articlesLoaded(articles: articles)
        }
    }
    
    func articleSelected(article: Article) {
        self.router.routeToDetailScreen(article: article)
    }
    
    func onError(error: Error) {
        var title = "Oops"
        var message = "Something went wrong getting articles"
        
        if let error = error as? NYTError, let errorTitle = error.title, let errorMessage = error.message {
            title = errorTitle
            message = errorMessage
        }
        
        DispatchQueue.main.async {
            self.view?.setIsLoading(false)
            self.view?.displayError(title: title, message: message)
        }
    }
    
    func onPaginationError(error: Error) {
        DispatchQueue.main.async {
            self.view?.setIsLoading(false)
            self.view?.displayPaginationError()
        }
    }
    
}
