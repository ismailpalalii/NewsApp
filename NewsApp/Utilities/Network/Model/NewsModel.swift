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

// MARK: - NewsModel Fake Data
extension NewsModel {
    static var fakeData: NewsModel {
        return NewsModel(
            status: "ok",
            sources: [
                Source(
                    id: "abc-news",
                    name: "ABC News",
                    description: "Your trusted source for breaking news, analysis, exclusive interviews, headlines, and videos at ABCNews.com.",
                    url: "https://abcnews.go.com",
                    category: Category(rawValue: "general") ?? .general,
                    language: "en",
                    country: "us"
                ),
                Source(
                    id: "bbc-news",
                    name: "BBC News",
                    description: "The latest BBC News news from the UK and around the world, breaking news, features, analysis and special reports.",
                    url: "https://www.bbc.co.uk/news",
                    category: Category(rawValue: "general") ?? .general,
                    language: "en",
                    country: "uk"
                ),
                Source(
                    id: "techcrunch",
                    name: "TechCrunch",
                    description: "TechCrunch is a leading technology media property, dedicated to obsessively profiling startups, reviewing new Internet products, and breaking tech news.",
                    url: "https://techcrunch.com",
                    category: Category(rawValue: "technology") ?? .technology,
                    language: "en",
                    country: "us"
                )
            ]
        )
    }
}
