//
//  HomeScreenRouter.swift
//  NYT
//
//  Created Julian Panucci on 2/4/20.
//  Copyright © 2020 Panucci. All rights reserved.
//
//

import UIKit

class HomeScreenRouter: HomeScreenRouterProtocol {
    
    weak var viewController: UIViewController?
    
    func routeToDetailScreen(article: Article) {
        if let detailVC = DetailScreenBuilder.createModule() as? DetailScreenViewController {
            detailVC.article = article
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
