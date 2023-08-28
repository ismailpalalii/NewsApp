//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by İsmail Palalı on 27/08/2023.
//

import Foundation

protocol NewsViewModelDelegate: BaseViewModelDelegate {
    var view: NewsViewDelegate? { get set }
}

final class NewsViewModel {

    weak var view: NewsViewDelegate?
    private let service: NetworkService

    var sourceList: [Source] = [] // News sources
    var allCategories: Set<Category> = [] // All categories

    init(view: NewsViewDelegate? = nil, service: NetworkService = NetworkService()) {
        self.view = view
        self.service = service
    }

    func getNewsSource() {
        self.view?.showIndicator()
        service.fetchNews { [weak self] response in
            self?.view?.hideIndicator()
            guard let response = response else { return }

            // Filter English language only
            let englishSources = response.sources.filter { $0.language == "en" }
            self?.sourceList = englishSources

            // Extract all categories
            for source in response.sources {
                let sourceCategory = source.category
                self?.allCategories.insert(sourceCategory)
            }

            DispatchQueue.main.async {
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
