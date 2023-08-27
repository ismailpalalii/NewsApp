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
    //func fetchNewsDetail(id: String, completion: @escaping (NewsDetail?) -> Void)
    //func fetchNewsCategory(category: String, completion: @escaping (NewsModel?) -> Void)
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

//    func fetchNewsDetail(id: String, completion: @escaping (NewsDetail?) -> Void) {
//        <#code#>
//    }
//
//    func fetchNewsCategory(category: String, completion: @escaping (NewsModel?) -> Void) {
//        <#code#>
//    }

//    func fetchNewsCategory(category: String, onSuccess: @escaping (NewsModel?) -> Void, onError: @escaping (Alamofire.AFError) -> Void) {
//
//    }
//
//    func fetchNewsDetail(id: String, onSuccess: @escaping (NewsDetail?) -> Void, onError: @escaping (Alamofire.AFError) -> Void) {
//        NetworkManager.shared.fetch(path: Constant.Network.ServiceEndPoint.fetchNewsDetailPath(id: id)) { (response: NewsDetail) in
//            onSuccess(response)
//        } onError: { error in
//            onError(error)
//        }
//    }
//
//    func fetchNews(onSuccess: @escaping (NewsModel?) -> Void, onError: @escaping (AFError) -> Void) {
//        NetworkManager.shared.fetch(path: Constant.Network.ServiceEndPoint.fetchNewsPath()) { (response: NewsModel) in
//            onSuccess(response)
//        } onError: { error in
//            onError(error)
//        }
//    }
}
