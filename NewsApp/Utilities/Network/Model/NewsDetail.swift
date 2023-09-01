//
//  NewsDetail.swift
//  NewsApp
//
//  Created by İsmail Palalı on 26.08.2023.
//

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

// MARK: - NewsModel Fake Data
extension NewsDetail {
    static var fakeData: NewsDetail {
        return NewsDetail(
            status: "ok",
            totalResults: 3,
            articles: [
                Article(
                    title: "Gabon coup: Army seizes power from Ali Bongo and puts him in house arrest",
                    description: "Gabon's President Ali Bongo has appealed for help after the army deposed him in a coup.",
                    url: "http://www.bbc.co.uk/news/world-africa-66654965",
                urlToImage:
                        "https://ichef.bbci.co.uk/news/1024/branded_news/70F2/production/_130941982_23850be5d329579675dae1348e849cf77a7fe9b20_0_4256_28321000x665.jpg",
                    publishedAt: "2023-08-30T17:07:26.0665475Z"
                ),
                Article(
                    title: "Ukraine gains on southern front could open way to Crimea, says Kyiv",
                    description: "Recent gains by Ukrainian troops on the southern front could open the way for pushing the Russians back to the annexed Crimean peninsula.",
                    url: "http://www.bbc.co.uk/news/world-europe-66662851",
                    urlToImage: "https://ichef.bbci.co.uk/news/1024/branded_news/EF8C/production/_130942316_f99076fbc7a0579210c611c2a396698a3a3061d8-1.jpg",
                    publishedAt: "2023-08-30T17:07:22.8316656Z"
                ),
                Article(
                    title: "Why won't the US call this coup a coup?",
                    description: "The military took over the government in Niger. Here’s why the US doesn’t want to call it an overthrow.",
                    url: "http://www.bbc.co.uk/news/world-africa-66630354",
                    urlToImage: "https://ichef.bbci.co.uk/news/1024/branded_news/15C7B/production/_130911298_p0g919j3.jpg",
                    publishedAt: "2023-08-30T16:07:21.940987Z"
                ),
                Article(
                    title: "Why won't the US call this coup a coup?",
                    description: "The military took over the government in Niger. Here’s why the US doesn’t want to call it an overthrow.",
                    url: "http://www.bbc.co.uk/news/world-africa-66630354",
                    urlToImage: "https://ichef.bbci.co.uk/news/1024/branded_news/15C7B/production/_130911298_p0g919j3.jpg",
                    publishedAt: "2023-08-30T16:07:21.940987Z"
                ),
                Article(
                    title: "Why won't the US call this coup a coup?",
                    description: "The military took over the government in Niger. Here’s why the US doesn’t want to call it an overthrow.",
                    url: "http://www.bbc.co.uk/news/world-africa-66630354",
                    urlToImage: "https://ichef.bbci.co.uk/news/1024/branded_news/15C7B/production/_130911298_p0g919j3.jpg",
                    publishedAt: "2023-08-30T16:07:21.940987Z"
                ),
                Article(
                    title: "Why won't the US call this coup a coup?",
                    description: "The military took over the government in Niger. Here’s why the US doesn’t want to call it an overthrow.",
                    url: "http://www.bbc.co.uk/news/world-africa-66630354",
                    urlToImage: "https://ichef.bbci.co.uk/news/1024/branded_news/15C7B/production/_130911298_p0g919j3.jpg",
                    publishedAt: "2023-08-30T16:07:21.940987Z"
                ),
                Article(
                    title: "Why won't the US call this coup a coup?",
                    description: "The military took over the government in Niger. Here’s why the US doesn’t want to call it an overthrow.",
                    url: "http://www.bbc.co.uk/news/world-africa-66630354",
                    urlToImage: "https://ichef.bbci.co.uk/news/1024/branded_news/15C7B/production/_130911298_p0g919j3.jpg",
                    publishedAt: "2023-08-30T16:07:21.940987Z"
                )
            ]
        )
    }
}
