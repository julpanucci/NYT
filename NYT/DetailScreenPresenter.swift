//
//  DetailScreenPresenter.swift
//  NYT
//
//  Created Julian Panucci on 2/4/20.
//  Copyright © 2020 Panucci. All rights reserved.
//
//

import UIKit

class DetailScreenPresenter: DetailScreenPresenterProtocol {

    weak private var view: DetailScreenViewProtocol?
    var interactor: DetailScreenInteractorProtocol?
    private let router: DetailScreenRouterProtocol

    init(interface: DetailScreenViewProtocol, interactor: DetailScreenInteractorProtocol?, router: DetailScreenRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
