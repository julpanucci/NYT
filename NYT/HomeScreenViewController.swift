//
//  HomeScreenViewController.swift
//  NYT
//
//  Created Julian Panucci on 2/4/20.
//  Copyright © 2020 Panucci. All rights reserved.
//
//

import UIKit

class HomeScreenViewController: UIViewController, HomeScreenViewProtocol {
    
    var presenter: HomeScreenPresenterProtocol?
    
    var articles = [Article]()
    var page = 0
    var searchText: String?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = headerView
        tableView.backgroundView = loadingView
        return tableView
    }()
    
    lazy var headerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 100))
        view.backgroundColor = .white
        
        view.addSubview(searchField)
        NSLayoutConstraint.activate([
            self.searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            self.searchField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            self.searchField.heightAnchor.constraint(equalToConstant: 20),
        ])
        return view
    }()
    
    lazy var searchField: UITextField = {
        let searchField = UITextField()
        searchField.textColor = .black
        searchField.font = UIFont.systemFont(ofSize: 18)
        searchField.backgroundColor = .white
        searchField.tintColor = .black
        searchField.layer.cornerRadius = 4.0
        searchField.clearButtonMode = .always
        searchField.autocorrectionType = .no
        searchField.autocapitalizationType = .none
        searchField.placeholder = "Search"
        searchField.returnKeyType = .search
        searchField.translatesAutoresizingMaskIntoConstraints = false
        
        let searchIcon = UIImageView(image: UIImage(named: "search_icon"))
        searchIcon.tintColor = .black
        
        searchField.leftView = searchIcon
        searchField.leftViewMode = .always
        return searchField
    }()
    
    lazy var loadingView: LoadingView = {
        let view = LoadingView(frame: self.view.frame)
        view.descriptionText = "Searching for articles..."
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .green
        
        self.setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.presenter?.getArticles(searchText: "election", page: 0)
    }
    
    func setConstraints() {
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
    
    func setIsLoading(_ isLoading: Bool) {
        if isLoading {
            self.tableView.backgroundView?.isHidden = false
            self.loadingView.startLoading()
        } else {
            self.tableView.backgroundView?.isHidden = true
            self.loadingView.stopLoading()
        }
    }
    
    func articlesLoaded(articles: [Article]) {
        self.articles.append(contentsOf: articles)
        self.tableView.reloadData()
    }
    
    func displayError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(dismiss)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension HomeScreenViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell {
            let article = articles[indexPath.row]
            cell.article = article
            return cell
        }
        
        return UITableViewCell()
    }
}

extension HomeScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.articles.count - 1 {
            page += 1
            self.presenter?.getArticles(searchText: "election", page: page)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
