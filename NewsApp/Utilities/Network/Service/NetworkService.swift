//
//  NetworkService.swift
//  NewsApp
//
//  Created by İsmail Palalı on 26.08.2023.
//

import Alamofire

// MARK: - ServiceProtocol
protocol NetworkServiceProtocol: AnyObject {
    func fetchNews(completion: @escaping (NewsModel?) -> Void)
}

// MARK: - Services
final class NetworkService: NetworkServiceProtocol {
    func fetchNews(completion: @escaping (NewsModel?) -> Void) {
        NetworkManager.shared.fetch(url: Constant.Network.ServiceEndPoint.fetchNewsPath(), responseType: NewsModel.self) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let err):
                print("err:", err.localizedDescription)
            }
        }
    }
}
