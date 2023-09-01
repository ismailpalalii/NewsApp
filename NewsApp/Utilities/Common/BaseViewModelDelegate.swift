//
//  BaseViewModelDelegate.swift
//  NewsApp
//
//  Created by İsmail Palalı on 27.08.2023.
//

import Foundation

// MARK: BaseViewModelDelegate

protocol BaseViewModelDelegate: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidDisappear()
}

extension BaseViewModelDelegate {
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidDisappear() {}
}
