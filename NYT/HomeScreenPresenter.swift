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

}
