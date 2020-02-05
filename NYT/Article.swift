//
//  Article.swift
//  NYT
//
//  Created by Julian Panucci on 2/4/20.
//  Copyright © 2020 Panucci. All rights reserved.
//

import Foundation

// MARK: - SearchResponse
struct ArticleSearchResponse: Codable {
    var status, copyright: String?
    var articleResponse: ArticleResponse?
    
    enum CodingKeys: String, CodingKey {
        case articleResponse = "response"
        case status, copyright
    }
}

// MARK: - Response
struct ArticleResponse: Codable {
    var articles: [Article]?
    var meta: Meta?
    
    enum CodingKeys: String, CodingKey {
        case articles = "docs"
        case meta
    }
}

// MARK: - Article
struct Article: Codable {
    var abstract: String?
    var webURL: String?
    var multimedia: [Multimedia]?
    var headline: Headline?
    var pubDate: String?
    var byline: Byline?
    var id: String?
    
    var thumbnailURL: URL? {
        if let multiMedia = multimedia?.first(where: {$0.subtype == "thumbLarge"}), let urlString = multiMedia.url {
            let fullURL = "https://www.nytimes.com/\(urlString)"
            return URL(string: fullURL)
        }
        return nil
    }

    enum CodingKeys: String, CodingKey {
        case abstract
        case webURL = "web_url"
        case multimedia, headline
        case pubDate = "pub_date"
        case byline
        case id = "_id"
    }
}

// MARK: - Byline
struct Byline: Codable {
    var original: String?
    var person: [Person]?
}

// MARK: - Person
struct Person: Codable {
    var firstname: String?
    var middlename: String?
    var lastname: String?
}

// MARK: - Headline
struct Headline: Codable {
    var main: String?
}


// MARK: - Multimedia
struct Multimedia: Codable {
    var rank: Int?
    var subtype: String?
    var url: String?
    var height, width: Int?
    var subType, cropName: String?

    enum CodingKeys: String, CodingKey {
        case rank, subtype, url, height, width, subType
        case cropName = "crop_name"
    }
}


// MARK: - Meta
struct Meta: Codable {
    var hits, offset, time: Int?
}


