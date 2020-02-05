//
//  DetailScreenViewController.swift
//  NYT
//
//  Created Julian Panucci on 2/4/20.
//  Copyright © 2020 Panucci. All rights reserved.
//
//

import UIKit

class DetailScreenViewController: UIViewController, DetailScreenViewProtocol {

	var presenter: DetailScreenPresenterProtocol?
    var article: Article?

	override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .green
    }

}
