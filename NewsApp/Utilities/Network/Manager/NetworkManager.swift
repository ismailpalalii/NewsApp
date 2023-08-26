//
//  NetworkManager.swift
//  NewsApp
//
//  Created by İsmail Palalı on 26.08.2023.
//

import Foundation
import Alamofire

// MARK: - Generic Service Manager
final class NetworkManager {
    static let shared: NetworkManager = NetworkManager()
}

extension NetworkManager {
    func fetch<T>(path: String, onSuccess: @escaping (T) -> (), onError: (AFError) ->()) where T: Codable {
        AF.request(path, encoding: JSONEncoding.default).validate().responseDecodable(of: T.self) { response in
            guard let model = response.value else { print( response.error as Any ); return }
            onSuccess(model)
        }
    }
}

