//
//  NetworkManager.swift
//  NewsApp
//
//  Created by İsmail Palalı on 26.08.2023.
//

import Alamofire
import Foundation

// MARK: Network Manager
final class NetworkManager {
    static let shared = NetworkManager()

    func fetch<T: Decodable>(
        url: URLConvertible,
        responseType: T.Type,
        completion: @escaping (Result<T?, Error>) -> Void
    ) {
        AF
            .request(url)
            .responseDecodable(of: T.self,
                               queue: .global(qos: .userInitiated)
            ) { result in
                DispatchQueue.main.async {
                    switch result.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let err):
                        completion(.failure(err))
                }
            }
        }
    }
}
