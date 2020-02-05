//
//  HomeScreenInteractor.swift
//  NYT
//
//  Created Julian Panucci on 2/4/20.
//  Copyright © 2020 Panucci. All rights reserved.
//
//

import UIKit

class HomeScreenInteractor: HomeScreenInteractorProtocol {
    
    var articleService = ArticleService.shared

    weak var presenter: HomeScreenPresenterProtocol?
    
    func getArticles(searchText: String, page: Int) {
        self.articleService.getArticles(searchText: searchText, forPage: page) { (result) in
            switch result {
            case .success(let articles):
                self.presenter?.onArticlesLoaded(articles: articles)
            case .failure(let error):
                self.presenter?.onError(error: error)
            }
        }
    }
}
