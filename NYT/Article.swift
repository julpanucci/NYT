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
    var snippet, leadParagraph, printSection, printPage: String?
    var source: Source?
    var multimedia: [Multimedia]?
    var headline: Headline?
    var keywords: [Keyword]?
    var pubDate: String?
    var documentType: DocumentType?
    var newsDesk: NewsDesk?
    var sectionName: SectionName?
    var subsectionName: SubsectionName?
    var byline: Byline?
    var typeOfMaterial: TypeOfMaterial?
    var id: String?
    var wordCount: Int?
    var uri: String?
    
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
        case snippet
        case leadParagraph = "lead_paragraph"
        case printSection = "print_section"
        case printPage = "print_page"
        case source, multimedia, headline, keywords
        case pubDate = "pub_date"
        case documentType = "document_type"
        case newsDesk = "news_desk"
        case sectionName = "section_name"
        case subsectionName = "subsection_name"
        case byline
        case typeOfMaterial = "type_of_material"
        case id = "_id"
        case wordCount = "word_count"
        case uri
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
    var role: Role?
    var organization: String?
    var rank: Int?
}

enum Role: String, Codable {
    case reported = "reported"
}

enum DocumentType: String, Codable {
    case article = "article"
}

// MARK: - Headline
struct Headline: Codable {
    var main: String?
    var kicker: TypeOfMaterial?
    var printHeadline: String?

    enum CodingKeys: String, CodingKey {
        case main, kicker
        case printHeadline = "print_headline"
    }
}

enum TypeOfMaterial: String, Codable {
    case news = "News"
    case newsAnalysis = "News Analysis"
}

// MARK: - Keyword
struct Keyword: Codable {
    var name: Name?
    var value: String?
    var rank: Int?
    var major: Major?
}

enum Major: String, Codable {
    case n = "N"
}

enum Name: String, Codable {
    case glocations = "glocations"
    case organizations = "organizations"
    case persons = "persons"
    case subject = "subject"
}

// MARK: - Multimedia
struct Multimedia: Codable {
    var rank: Int?
    var subtype: String?
    var type: TypeEnum?
    var url: String?
    var height, width: Int?
    var legacy: Legacy?
    var subType, cropName: String?

    enum CodingKeys: String, CodingKey {
        case rank, subtype, type, url, height, width, legacy, subType
        case cropName = "crop_name"
    }
}

// MARK: - Legacy
struct Legacy: Codable {
    var xlarge: String?
    var xlargewidth, xlargeheight: Int?
    var thumbnail: String?
    var thumbnailwidth, thumbnailheight, widewidth, wideheight: Int?
    var wide: String?
}

enum TypeEnum: String, Codable {
    case image = "image"
}

enum NewsDesk: String, Codable {
    case washington = "Washington"
}

enum SectionName: String, Codable {
    case uS = "U.S."
}

enum Source: String, Codable {
    case theNewYorkTimes = "The New York Times"
}

enum SubsectionName: String, Codable {
    case politics = "Politics"
}

// MARK: - Meta
struct Meta: Codable {
    var hits, offset, time: Int?
}


