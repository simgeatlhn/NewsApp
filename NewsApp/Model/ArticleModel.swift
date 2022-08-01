//
//  ArticleModel.swift
//  NewsApp
//
//  Created by simge on 1.08.2022.
//

import Foundation


struct ArticleList: Codable {
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let author: String?
    let title, articleDescription: String?
    let url: String?
    let urlToImage: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case author, title
        case articleDescription = "description"
        case url, urlToImage, content
    }
}

