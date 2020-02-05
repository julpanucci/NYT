//
//  ArticleService.swift
//  NYT
//
//  Created by Julian Panucci on 2/4/20.
//  Copyright © 2020 Panucci. All rights reserved.
//

import Foundation

class ArticleService: HTTPService {
    
    static let shared = ArticleService()
    
    let baseURL = Constants.ArticleService.baseURL
    let apiKey = Constants.ArticleService.apiKey
    
    typealias ArticleResult = (Result<[Article], Error>) -> Void
    
    func getArticles(searchText: String, forPage page: Int,completion: @escaping ArticleResult) {
        guard let url = URL(string: "\(baseURL)") else {
            print("Error with url: \(baseURL)")
            return
        }
        
        let pageQuery = String(page)
        let parameters: [String : String] = ["api-key": self.apiKey, "page": pageQuery, "q": searchText]
        
        self.sendRequest(url: url, method: .get, body: nil, queryParams: parameters) { (result: Result<ArticleSearchResponse, Error>)  in
            switch result {
            case .success(let searchResponse):
                if let articles = searchResponse.articleResponse?.articles {
                    completion(.success(articles))
                } else {
                    fatalError("Something went wrong getting the articles")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
