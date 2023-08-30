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
    func fetchDetailNews(id: String, completion: @escaping (NewsDetail?) -> Void)
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

    func fetchDetailNews(id: String, completion: @escaping (NewsDetail?) -> Void) {
        NetworkManager.shared.fetch(url: Constant.Network.ServiceEndPoint.fetchNewsDetailPath(id: id), responseType: NewsDetail.self) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let err):
                print("err:", err.localizedDescription)
            }
        }
    }
}
