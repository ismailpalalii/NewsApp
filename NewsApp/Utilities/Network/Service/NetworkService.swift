//
//  NetworkService.swift
//  NewsApp
//
//  Created by İsmail Palalı on 26.08.2023.
//

import Alamofire
import UIKit

// MARK: - ServiceProtocol
protocol NetworkServiceProtocol: AnyObject {
    func fetchNews(completion: @escaping (Result<NewsModel?, APIError>) -> Void)
    func fetchDetailNews(id: String, completion: @escaping (Result<NewsDetail?, APIError>) -> Void)
}

// MARK: - Services
final class NetworkService: NetworkServiceProtocol {

    func fetchNews(completion: @escaping (Result<NewsModel?, APIError>) -> Void) {
        NetworkManager.shared.fetch(url: Constant.Network.ServiceEndPoint.fetchNewsPath(), responseType: NewsModel.self) { result in
            switch result {
            case .success(let data):
                if let newsDetail = data {
                    completion(.success(newsDetail))
                } else {
                    let error = APIError.dataNotFound
                    completion(.failure(error))
                }
            case .failure(let err):
                let apiError = APIError.networkError(err)
                completion(.failure(apiError))
            }
        }
    }

    func fetchDetailNews(id: String, completion: @escaping (Result<NewsDetail?, APIError>) -> Void) {
        NetworkManager.shared.fetch(url: Constant.Network.ServiceEndPoint.fetchNewsDetailPath(id: id), responseType: NewsDetail.self) { result in
            switch result {
            case .success(let data):
                if let newsDetail = data {
                    completion(.success(newsDetail))
                } else {
                    let error = APIError.dataNotFound
                    completion(.failure(error))
                }
            case .failure(let err):
                let apiError = APIError.networkError(err)
                completion(.failure(apiError))
            }
        }
    }
}
