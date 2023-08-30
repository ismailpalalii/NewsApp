//
//  NewsDetail.swift
//  NewsApp
//
//  Created by İsmail Palalı on 26.08.2023.
//

import Foundation
// MARK: - NewsDetail
struct NewsDetail: Codable {
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let author: String?
    let title, articleDescription: String?
    //let publishedAt: Date
    let url: String?
    let urlToImage: String?
    let content: String?
}
