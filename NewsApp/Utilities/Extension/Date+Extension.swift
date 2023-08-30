//
//  Date+Extension.swift
//  NewsApp
//
//  Created by İsmail Palalı on 30.08.2023.
//

import Foundation

extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
