//
//  ServiceConstant.swift
//  NewsApp
//
//  Created by İsmail Palalı on 26.08.2023.
//

import Foundation

// MARK: - Network Constant
extension Constant {

    class Network {

        enum ServiceEndPoint: String {
            case baseUrl = "https://newsapi.org/v2/top-headlines/sources?"
            case baseDetailUrl = "https://newsapi.org/v2/top-headlines?sources"
            case baseCategoryUrl = "https://newsapi.org/v2/top-headlines/sources?category"
            case apikey = "apiKey=8e9f2552595e46968c630269fe0eda98"

            //Check url path
            //https://newsapi.org/v2/top-headlines/sources?apiKey=8e9f2552595e46968c630269fe0eda98
            //https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=8e9f2552595e46968c630269fe0eda98
            //https://newsapi.org/v2/top-headlines/sources?category=businessapiKey=8e9f2552595e46968c630269fe0eda98
            
            static func fetchNewsPath() -> String {
                "\(ServiceEndPoint.baseUrl.rawValue)\(ServiceEndPoint.apikey.rawValue)"
            }
            static func fetchNewsDetailPath(id: String) -> String {
                "\(ServiceEndPoint.baseDetailUrl.rawValue)\("=\(id)&")\(ServiceEndPoint.apikey.rawValue)"
            }
            static func fetchNewsCategoryPath(category: String) -> String {
                "\(ServiceEndPoint.baseCategoryUrl.rawValue)\("=\(category)&")\(ServiceEndPoint.apikey.rawValue)"
            }
        }
    }
}
