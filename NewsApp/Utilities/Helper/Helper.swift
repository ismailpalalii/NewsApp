//
//  Helper.swift
//  NewsApp
//
//  Created by İsmail Palalı on 27.08.2023.
//

import Foundation

// MARK: Get Class Name
public extension NSObject {
    static var className: String {
        String(describing: self)
    }
    var className: String {
        String(describing: self)
    }
}
