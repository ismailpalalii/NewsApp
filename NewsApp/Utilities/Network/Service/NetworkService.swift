//
//  NetworkService.swift
//  NewsApp
//
//  Created by İsmail Palalı on 26.08.2023.
//

import Alamofire

// MARK: - ServiceProtocol
protocol NetworkServiceProtocol: AnyObject {
    func fetchArticles(onSuccess: @escaping (ArticleList?) -> Void, onError: @escaping (AFError) -> Void)
}

// MARK: - Services
final class NetworkService: NetworkServiceProtocol {

    func fetchArticles(onSuccess: @escaping (ArticleList?) -> Void, onError: @escaping (AFError) -> Void) {
        NetworkManager.shared.fetch(path: Constant.Network.ServiceEndPoint.fetchArticles()) { (response: ArticleList) in
            onSuccess(response)

        } onError: { error in
            onError(error)
        }
    }

}
