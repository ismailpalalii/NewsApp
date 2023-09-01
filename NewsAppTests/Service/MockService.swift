//
//  MockService.swift
//  NewsAppTests
//
//  Created by İsmail Palalı on 1.09.2023.
//

import XCTest
@testable import NewsApp

// Mock NetworkService
class MockNetworkService: NetworkServiceProtocol {
    var shouldReturnFakeData = false

    func fetchNews(completion: @escaping (Result<NewsModel?, APIError>) -> Void) {
        if shouldReturnFakeData {
            let fakeResponse = NewsModel.fakeData
            completion(.success(fakeResponse))
        } else {
            let error = APIError.dataNotFound
            completion(.failure(error))
        }
    }

    func fetchDetailNews(id: String, completion: @escaping (Result<NewsDetail?, APIError>) -> Void) {
        if shouldReturnFakeData {
            let fakeDetail = NewsDetail.fakeData
            completion(.success(fakeDetail))
        } else {
            let error = APIError.dataNotFound
            completion(.failure(error))
        }
    }
}
