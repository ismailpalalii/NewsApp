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
    func fetchNewsDetail(id: String, onSuccess: @escaping (NewsDetail?) -> Void, onError: @escaping (AFError) -> Void)
    func fetchNewsCategory(category: String, onSuccess: @escaping (NewsModel?) -> Void, onError: @escaping (AFError) -> Void)
}

// MARK: - Services
final class NetworkService: NetworkServiceProtocol {
    func fetchNewsCategory(category: String, onSuccess: @escaping (NewsModel?) -> Void, onError: @escaping (Alamofire.AFError) -> Void) {
        NetworkManager.shared.fetch(path: Constant.Network.ServiceEndPoint.fetchNewsCategoryPath(category: category)) { (response: NewsModel) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }

    func fetchNewsDetail(id: String, onSuccess: @escaping (NewsDetail?) -> Void, onError: @escaping (Alamofire.AFError) -> Void) {
        NetworkManager.shared.fetch(path: Constant.Network.ServiceEndPoint.fetchNewsDetailPath(id: id)) { (response: NewsDetail) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }

    func fetchNews(onSuccess: @escaping (NewsModel?) -> Void, onError: @escaping (AFError) -> Void) {
        NetworkManager.shared.fetch(path: Constant.Network.ServiceEndPoint.fetchNewsPath()) { (response: NewsModel) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
}
