//
//  NewsModel.swift
//  NewsApp
//
//  Created by İsmail Palalı on 26.08.2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let newsModel = try? JSONDecoder().decode(NewsModel.self, from: jsonData)

import Foundation

// MARK: - NewsModel
struct NewsModel: Codable {
    let status: String
    let sources: [Source]
}

// MARK: - Source
struct Source: Codable {
    let id, name, description: String
    let url: String
    let category: Category
    let language, country: String
}

enum Category: String, Codable {
    case business = "business"
    case entertainment = "entertainment"
    case general = "general"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
}
