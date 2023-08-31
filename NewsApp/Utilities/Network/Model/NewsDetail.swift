//
//  NewsDetail.swift
//  NewsApp
//
//  Created by İsmail Palalı on 26.08.2023.
//

//import Foundation
//// MARK: - NewsDetail
//struct NewsDetail: Codable {
//    let articles: [Article]?
//}
//
//// MARK: - Article
//struct Article: Codable {
//    let author: String?
//    let title, articleDescription: String?
//    //let publishedAt: Date
//    let url: String?
//    let urlToImage: String?
//    let content: String?
//}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let newsDetailModel = try? JSONDecoder().decode(NewsDetailModel.self, from: jsonData)

import Foundation

// MARK: - NewsDetailModel
struct NewsDetail: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let title, description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
}
