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
    var allCategories: [Category] = [] // All categories
    var selectedCategories: [Category] = [] // Selected categories

    private var originalSources: [Source] = [] // To keep the original sources

    init(view: NewsViewDelegate? = nil, service: NetworkService = NetworkService()) {
        self.view = view
        self.service = service
    }

    func getNewsSource() {
        view?.showIndicator()
        service.fetchNews { [weak self] response in
            self?.view?.hideIndicator()
            guard let response = response else { return }

            // Filter English language only
            let englishSources = response.sources.filter { $0.language == "en" }
            self?.sourceList = englishSources
            self?.originalSources = englishSources

            // Extract all categories
            for source in response.sources {
                let sourceCategory = source.category
                if !(self?.allCategories.contains(sourceCategory) ?? false) {
                    self?.allCategories.append(sourceCategory)
                }
            }

            // Select all categories by default
            self?.selectedCategories = []

            DispatchQueue.main.async {
                self?.view?.reloadData()
            }
        }
    }

    func toggleCategorySelection(_ category: Category) {
        if selectedCategories.contains(category) {
            selectedCategories.removeAll { $0 == category }
        } else {
            selectedCategories.append(category)
        }
        updateSourceList()
    }

    private func updateSourceList() {
        if selectedCategories.isEmpty {
            sourceList = originalSources
        } else {
            sourceList = originalSources.filter { source in
                selectedCategories.contains(source.category)
            }
        }
        view?.reloadData()
    }

    func isCategorySelected(_ category: Category) -> Bool {
        return selectedCategories.contains(category)
    }

    func didSelectItemAtTableview(
            _ indexPath: IndexPath
        ) {
            let sourceDetail = sourceList[indexPath.row]
            self.view?.goDetailScreen(sourceDetail)
        }
}

extension NewsViewModel: NewsViewModelDelegate {
    func viewWillAppear() {
        getNewsSource()
    }
}
