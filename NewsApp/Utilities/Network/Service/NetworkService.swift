//
//  NetworkService.swift
//  NewsApp
//
//  Created by İsmail Palalı on 26.08.2023.
//

import Alamofire

// MARK: - ServiceProtocol
protocol NetworkServiceProtocol: AnyObject {
    func fetchNews(onSuccess: @escaping (NewsModel?) -> Void, onError: @escaping (AFError) -> Void)
}

// MARK: - Services
final class NetworkService: NetworkServiceProtocol {

    func fetchNews(onSuccess: @escaping (NewsModel?) -> Void, onError: @escaping (AFError) -> Void) {
        NetworkManager.shared.fetch(path: Constant.Network.ServiceEndPoint.fetchNewsPath()) { (response: NewsModel) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
}
