//
//  DetailScreenRouter.swift
//  NYT
//
//  Created Julian Panucci on 2/4/20.
//  Copyright © 2020 Panucci. All rights reserved.
//
//

import UIKit

class DetailScreenRouter: DetailScreenRouterProtocol {
    
    weak var viewController: UIViewController?
    
    func presentShareActivity(url: URL) {
        let uiActivityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        uiActivityController.popoverPresentationController?.sourceView = self.viewController?.view
        self.viewController?.present(uiActivityController, animated: true, completion: nil)
    }
}
