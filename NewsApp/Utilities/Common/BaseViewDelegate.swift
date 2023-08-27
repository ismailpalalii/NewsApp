//
//  BaseViewDelegate.swift
//  NewsApp
//
//  Created by İsmail Palalı on 27.08.2023.
//

import Foundation

// MARK: BaseViewDelegate

protocol BaseViewDelegate: AnyObject {
    func showIndicator()
    func hideIndicator()
    func showRequestErrorPopUp(errorType: APIError)
}

extension BaseViewDelegate {
    func showIndicator() { }
    func hideIndicator() { }
    func showRequestErrorPopUp(errorType: APIError) { }
}

// MARK: Custom Error

enum APIError: Error {
    case invalidURL
    case networkError(Error)
    case dataNotFound
    case decodingError(Error)
    case customError(String)

    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .networkError(let error):
            return "Network Error: \(error.localizedDescription)"
        case .dataNotFound:
            return "Data not found"
        case .decodingError(let error):
            return "Decoding Error: \(error.localizedDescription)"
        case .customError(let message):
            return message
        }
    }
}
