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
    var searchText: String = ""
    
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
        view.backgroundColor = self.view.backgroundColor
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        titleLabel.font = UIFont.customFont(.chomsky, type: .regular, size: 30)
        titleLabel.text = "New York Times"
        
        
        view.addSubview(searchField)
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            titleLabel.widthAnchor.constraint(equalToConstant: view.bounds.width - 32),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            self.searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            self.searchField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            self.searchField.heightAnchor.constraint(equalToConstant: 36),
            self.searchField.widthAnchor.constraint(equalToConstant: view.bounds.width - 32),
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
        searchField.placeholder = "Search for an article"
        searchField.returnKeyType = .search
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.delegate = self
        
        let searchIcon = UIImageView(image: UIImage(named: "search_icon"))
        searchIcon.tintColor = .black
        
        searchField.leftView = searchIcon
        searchField.leftViewMode = .always
        return searchField
    }()
    
    lazy var loadingView: LoadingView = {
        let view = LoadingView(frame: self.view.frame)
        view.descriptionText = "Searching for articles..."
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0.01, green: 0.51, blue: 0.56, alpha: 1.00)
        
        self.setupNavigationController()
        
        self.setConstraints()
    }
    
    func setupNavigationController() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
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
            self.presenter?.getArticles(searchText: self.searchText, page: page)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension HomeScreenViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchText = textField.text ?? ""
        self.presenter?.getArticles(searchText: searchText, page: 0)
        return true
    }
}
