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
    private let service: NetworkService

    var sourceDetailList: [Article] = []
    var topNews: [Article] = []
    var sourceID = ""

    init(view: NewsDetailViewDelegate? = nil, service: NetworkService = NetworkService()) {
        self.view = view
        self.service = service
    }

    // MARK: Get News Detail Source List
    func getNewsDetailList() {
        service.fetchDetailNews(id: sourceID) { [weak self] response in
            self?.view?.hideIndicator()
            guard let response = response else { return }
            if let articles = response.articles, articles.count >= 3 {
                self?.sourceDetailList = Array(articles.dropFirst(3))
                self?.topNews = Array(articles.prefix(3))
            } else {
                self?.sourceDetailList = []
                self?.topNews = response.articles ?? []
            }
            DispatchQueue.main.async {
                self?.view?.reloadData()
            }
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
