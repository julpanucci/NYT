//
//  DetailScreenBuilder.swift
//  NYT
//
//  Created Julian Panucci on 2/4/20.
//  Copyright © 2020 Panucci. All rights reserved.
//
//

import UIKit

//MARK: Router -
protocol DetailScreenRouterProtocol: class {
    func presentShareActivity(url: URL)
}
//MARK: Presenter -
protocol DetailScreenPresenterProtocol: class {
    func loadURL(urlString: String)
    func shareButtonTapped(url: URL)
}

//MARK: Interactor -
protocol DetailScreenInteractorProtocol: class {
    
    var presenter: DetailScreenPresenterProtocol?  { get set }
}

//MARK: View -
protocol DetailScreenViewProtocol: class {
    
    var presenter: DetailScreenPresenterProtocol?  { get set }
    func setIsLoading(_ isLoading: Bool)
    func displayWebContent(content: String)
    func displayErrorView()
    func displayConnectionError()
    
}

class DetailScreenBuilder {
    static func createModule() -> UIViewController {
        
        let view = DetailScreenViewController(nibName: nil, bundle: nil)
        let interactor = DetailScreenInteractor()
        let router = DetailScreenRouter()
        let presenter = DetailScreenPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
