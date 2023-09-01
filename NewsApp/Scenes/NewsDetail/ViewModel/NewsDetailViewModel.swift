//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by İsmail Palalı on 30.08.2023.
//

import Foundation

// MARK: NewsViewModelDelegate
protocol NewsDetailViewModelDelegate: BaseViewModelDelegate {
    var view: NewsDetailViewDelegate? { get set }
}
final class NewsDetailViewModel {

    weak var view: NewsDetailViewDelegate?
    private let service: NetworkServiceProtocol
    private var coreDataService: CoreDataService

    var sourceDetailList: [Article] = []
    var topNews: [Article] = []
    var sourceID = ""

    init(view: NewsDetailViewDelegate? = nil,
         service: NetworkServiceProtocol,
         coreDataService: CoreDataService = CoreDataService()) {
        self.view = view
        self.coreDataService = coreDataService
        self.service = service
    }

    // MARK: Get News Detail Source List
    func getNewsDetailList() {
        service.fetchDetailNews(id: sourceID) { [weak self] result in
            self?.view?.hideIndicator()

            switch result {
            case .success(let response):
                guard let newsDetail = response else {
                    self?.view?.showRequestErrorPopUp(title: "Error", message: APIError.dataNotFound.localizedDescription)
                    return }

                // Sort articles by date in descending order
                let sortedArticles = newsDetail.articles?.sorted(by: { $0.formattedPublishedDate() > $1.formattedPublishedDate() }) ?? []

                if sortedArticles.count >= 3 {
                    self?.sourceDetailList = Array(sortedArticles.dropFirst(3))
                    self?.topNews = Array(sortedArticles.prefix(3))
                } else {
                    self?.sourceDetailList = []
                    self?.topNews = sortedArticles
                }
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

    func saveToCoreData(title: String) {
        coreDataService.saveData(title: title)
    }

    func deleteToCoreData(title: String) {
        coreDataService.deleteData(title: title)
    }

    func fetchData() -> [SaveNews]? {
        coreDataService.fetchData()
    }

    func toggleReadingListStatus(for news: Article) {
        if let existingNews = fetchData()?.first(where: { $0.title == news.title }) {
            coreDataService.deleteData(title: existingNews.title ?? "")
        } else {
            saveToCoreData(title: news.title ?? "")
        }
    }

}

// MARK: NewsDetailViewModelDelegate
extension NewsDetailViewModel: NewsDetailViewModelDelegate {
    func viewWillAppear() {
        self.view?.setSourceID()
        self.view?.setCollectionView()
        getNewsDetailList()
    }
}
