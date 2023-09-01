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
            //case apikey = "apiKey=fd00a14f46984e01badc5131229f4dc0"

            // MARK: Fetch news path
            static func fetchNewsPath() -> String {
                "\(ServiceEndPoint.baseUrl.rawValue)\(ServiceEndPoint.apikey.rawValue)"
            }

            // MARK: Fetch news detail path
            static func fetchNewsDetailPath(id: String) -> String {
                "\(ServiceEndPoint.baseDetailUrl.rawValue)\("=\(id)&")\(ServiceEndPoint.apikey.rawValue)"
            }
        }
    }
}
