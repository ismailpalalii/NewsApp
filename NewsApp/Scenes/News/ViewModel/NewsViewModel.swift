//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by İsmail Palalı on 27.08.2023.
//

import Foundation

protocol NewsViewModelDelegate: BaseViewModelDelegate {
    var view: NewsViewDelegate? { get set }
}

final class NewsViewModel {

    weak var view: NewsViewDelegate?
    private let  service: NetworkService

    var sourceList: [Source]? = []
    var allCategories: [Category] = []

    init(view: NewsViewDelegate? = nil, service: NetworkService = NetworkService()) {
        self.view = view
        self.service = service
    }

    func getNewsSource() {
        self.view?.showIndicator()
        service.fetchNews { [weak self] response in
            self?.view?.hideIndicator()
            guard let response = response else { return }

            var allCategories: Set<Category> = []

            // MARK: Filter english language
            let englishSources = response.sources.filter { $0.language == "en" }
            self?.sourceList = englishSources

            // MARK: Filter category list
            for source in response.sources {
                let sourceCategory = source.category // This is a single Category value
                allCategories.insert(sourceCategory)
            }

            DispatchQueue.main.async {
                // Now you can use allCategories as needed
                self?.view?.reloadData()
            }
        }
    }

}

    extension NewsViewModel: NewsViewModelDelegate {
        func viewWillAppear() {
            getNewsSource()
        }
    }
