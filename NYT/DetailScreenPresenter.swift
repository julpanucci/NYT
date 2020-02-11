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
    
    var reachabilityService = ReachabilityService.shared

    init(interface: DetailScreenViewProtocol, interactor: DetailScreenInteractorProtocol?, router: DetailScreenRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func loadURL(urlString: String) {
        if reachabilityService.connectionIsUnavailable() {
            DispatchQueue.main.async {
                self.view?.setIsLoading(false)
                self.view?.displayConnectionError()
            }
        } else {
            self.view?.setIsLoading(true)
            if let url = URL(string: urlString) {
                do {
                    let content = try String(contentsOf: url)
                    DispatchQueue.main.async {
                        self.view?.setIsLoading(false)
                        self.view?.displayWebContent(content: content)
                    }
                } catch (_) {
                    DispatchQueue.main.async {
                        self.view?.setIsLoading(false)
                        self.view?.displayErrorView()
                    }
                }
            }
        }
    }
    
    func shareButtonTapped(url: URL) {
        self.router.presentShareActivity(url: url)
    }
}
