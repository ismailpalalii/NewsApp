//
//  Article+Extension.swift
//  NewsApp
//
//  Created by İsmail Palalı on 31.08.2023.
//

import Foundation

// MARK: Date formatter
extension Article {
    func formattedPublishedDate() -> String {
        let inputFormatter = ISO8601DateFormatter()
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM d, yyyy 'at' HH:mm"

        if let date = inputFormatter.date(from: publishedAt) {
            return outputFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
}
