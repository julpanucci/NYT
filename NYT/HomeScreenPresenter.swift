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

    weak private var view: HomeScreenViewProtocol?
    var interactor: HomeScreenInteractorProtocol?
    private let router: HomeScreenRouterProtocol

    init(interface: HomeScreenViewProtocol, interactor: HomeScreenInteractorProtocol?, router: HomeScreenRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func getArticles(searchText: String, page: Int) {
        self.interactor?.getArticles(searchText: searchText, page: page)
        DispatchQueue.main.async {
            self.view?.setIsLoading(true)
        }
    }
    
    func onArticlesLoaded(articles: [Article]) {
        DispatchQueue.main.async {
            self.view?.setIsLoading(false)
            self.view?.articlesLoaded(articles: articles)
        }
    }
    
    func onError(error: Error) {
        let title = "Oops"
        let message = "Something went wrong getting articles"
        DispatchQueue.main.async {
            self.view?.setIsLoading(false)
            self.view?.displayError(title: title, message: message)
        }
    }

}
