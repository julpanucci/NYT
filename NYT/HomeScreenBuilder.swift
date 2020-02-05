//
//  HomeScreenBuilder.swift
//  NYT
//
//  Created Julian Panucci on 2/4/20.
//  Copyright © 2020 Panucci. All rights reserved.
//
//

import UIKit

//MARK: Router -
protocol HomeScreenRouterProtocol: class {
    
}
//MARK: Presenter -
protocol HomeScreenPresenterProtocol: class {
    func getArticles(searchText: String, page: Int)
    func onArticlesLoaded(articles: [Article])
    func onError(error: Error)
}

//MARK: Interactor -
protocol HomeScreenInteractorProtocol: class {
    
    var presenter: HomeScreenPresenterProtocol?  { get set }
    
    func getArticles(searchText: String, page: Int)
}

//MARK: View -
protocol HomeScreenViewProtocol: class {
    
    var presenter: HomeScreenPresenterProtocol?  { get set }
    func articlesLoaded(articles: [Article])
    func displayError(title: String, message: String)
}

class HomeScreenBuilder {
    static func createModule() -> UIViewController {
        
        let view = HomeScreenViewController(nibName: nil, bundle: nil)
        let interactor = HomeScreenInteractor()
        let router = HomeScreenRouter()
        let presenter = HomeScreenPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
