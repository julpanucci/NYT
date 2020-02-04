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

}

//MARK: Interactor -
protocol HomeScreenInteractorProtocol: class {

  var presenter: HomeScreenPresenterProtocol?  { get set }
}

//MARK: View -
protocol HomeScreenViewProtocol: class {

  var presenter: HomeScreenPresenterProtocol?  { get set }
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
