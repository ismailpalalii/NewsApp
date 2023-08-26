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

            case BASE_URL = "https://newsapi.org/v2/top-headlines/sources?"
            case API_KEY = "apiKey=8e9f2552595e46968c630269fe0eda9"

            //https://newsapi.org/v2/top-headlines/sources?apiKey=8e9f2552595e46968c630269fe0eda98
            
            static func fetchNewsPath() -> String {
                "\(ServiceEndPoint.BASE_URL.rawValue)\(ServiceEndPoint.API_KEY.rawValue)"
            }
        }
    }
}
