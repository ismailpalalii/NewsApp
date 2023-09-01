//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by İsmail Palalı on 27/08/2023.
//

import Foundation

// MARK: NewsViewModelDelegate
protocol NewsViewModelDelegate: BaseViewModelDelegate {
    var view: NewsViewDelegate? { get set }
}

final class NewsViewModel {

    weak var view: NewsViewDelegate?
    private let service: NetworkServiceProtocol

    var sourceList: [Source] = [] // News sources
    var allCategories: [Category] = [] // All categories
    var selectedCategories: [Category] = [] // Selected categories

    private var originalSources: [Source] = [] // To keep the original sources

    init(view: NewsViewDelegate? = nil, service: NetworkServiceProtocol) {
        self.view = view
        self.service = service
    }

    // MARK: Get Source List
    func getNewsSource() {
        self.view?.showIndicator()
        service.fetchNews { [weak self] result in
            self?.view?.hideIndicator()

            switch result {
            case .success(let response):
                // Make sure response is non-nil
                guard let newsModel = response else {
                    self?.view?.showRequestErrorPopUp(title: "Error", message: APIError.dataNotFound.localizedDescription)
                    return
                }

                // MARK: Filter English language only
                let englishSources = newsModel.sources.filter { $0.language == "en" }
                self?.sourceList = englishSources
                self?.originalSources = englishSources

                // MARK: Extract all categories
                for source in newsModel.sources {
                    let sourceCategory = source.category
                    if !(self?.allCategories.contains(sourceCategory) ?? false) {
                        self?.allCategories.append(sourceCategory)
                    }
                }

                // MARK: Select all categories by default
                self?.selectedCategories = []

                DispatchQueue.main.async {
                    self?.view?.reloadData()
                }

            case .failure(let error):
                let errorMessage: String
                switch error {
                case .invalidURL:
                    errorMessage = "Invalid URL"
                case .networkError(let networkError):
                    errorMessage = "Network Error: \(networkError.localizedDescription)"
                case .dataNotFound:
                    errorMessage = "Data not found"
                case .decodingError(let decodingError):
                    errorMessage = "Decoding Error: \(decodingError.localizedDescription)"
                case .customError(let message):
                    errorMessage = message
                }
                self?.view?.showRequestErrorPopUp(title: "Error", message: errorMessage)
            }
        }
    }

    // MARK: Check category
    func toggleCategorySelection(_ category: Category) {
        if selectedCategories.contains(category) {
            selectedCategories.removeAll { $0 == category }
        } else {
            selectedCategories.append(category)
        }
        updateSourceList()
    }

    // MARK: Update source list
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

    // MARK: Check category item
    func isCategorySelected(_ category: Category) -> Bool {
        return selectedCategories.contains(category)
    }

    // MARK: Select Item At Tableview
    func didSelectItemAtTableview(
            _ indexPath: IndexPath
        ) {
            let sourceDetail = sourceList[indexPath.row]
            self.view?.goDetailScreen(sourceDetail)
        }
}

// MARK: NewsViewModelDelegate
extension NewsViewModel: NewsViewModelDelegate {
    func viewWillAppear() {
        self.view?.setTableView()
        self.view?.setCollectionView()
        getNewsSource()
    }
}
