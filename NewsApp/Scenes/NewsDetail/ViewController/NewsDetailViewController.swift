//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by İsmail Palalı on 30.08.2023.
//

import UIKit
import SnapKit

// MARK: NewsViewDelegate
protocol NewsDetailViewDelegate: BaseViewDelegate {
    func setCollectionView()
    func setSourceID()
    func reloadData()
}

final class NewsDetailViewController: BaseViewController {

    // MARK: Create UI items
    private lazy var sliderCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()

    private lazy var newsListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.hidesWhenStopped = true
        return indicator
    }()

    private lazy var pageController: UIPageControl = {
            let page = UIPageControl()
            page.numberOfPages = 3
            page.currentPage = 0
            page.pageIndicatorTintColor = UIColor.gray
            page.currentPageIndicatorTintColor = UIColor.blue
            return page
        }()

    private lazy var refreshControl = UIRefreshControl()

    var sourceTitle: String?
    var sourceID: String?
    var currentPage = 0

    // MARK: ViewModel
    private var viewModel = NewsDetailViewModel()

    init(sourceTitle: String? = nil, sourceID: String? = nil) {
        self.sourceTitle = sourceTitle
        self.sourceID = sourceID
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: lifeCycleInfo
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
        viewModel.viewWillAppear()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        configure()
    }

    // MARK: - UI Configure
    private func configure() {
        title = sourceTitle
        view.backgroundColor = .systemBackground
        view.addSubview(sliderCollectionView)
        view.addSubview(newsListCollectionView)
        view.addSubview(activityIndicator)
        view.addSubview(pageController)

        newsListCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        // MARK: Constraints
        sliderCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalToSuperview().multipliedBy(0.40)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }

        newsListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(pageController.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }

        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        pageController.snp.makeConstraints { make in
            make.top.equalTo(sliderCollectionView.snp.bottom).offset(-32)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.30)
            make.height.equalToSuperview().multipliedBy(0.05)
        }
    }

    // MARK: Pull to refresh source list data
    @objc private func refreshData() {
        viewModel.getNewsDetailList()
    }
}

// MARK: UICollectionView Delegate
extension NewsDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == sliderCollectionView ? viewModel.topNews.count : viewModel.sourceDetailList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sliderCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsDetailCollectionViewCell.identifier, for: indexPath) as? NewsDetailCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setNewsDetail(viewModel.topNews[indexPath.row])
                return cell
            } else if collectionView == newsListCollectionView {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsDetailCollectionViewCell.identifier, for: indexPath) as? NewsDetailCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.setNewsDetail(viewModel.sourceDetailList[indexPath.row])
                    return cell
            }
            return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView == sliderCollectionView ? CGSize(width: collectionView.frame.width, height: collectionView.frame.height) : CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 2 + 100)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            pageController.currentPage = indexPath.row
        }
}

// MARK: NewsDetailViewDelegate Delegate
extension NewsDetailViewController: NewsDetailViewDelegate {
    func setSourceID() {
        viewModel.sourceID = sourceID ?? ""
    }

    func reloadData() {
        sliderCollectionView.reloadData()
        newsListCollectionView.reloadData()

        activityIndicator.stopAnimating()
        refreshControl.endRefreshing()
    }

    func setCollectionView() {
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self

        newsListCollectionView.delegate = self
        newsListCollectionView.dataSource = self

        newsListCollectionView.register(NewsDetailCollectionViewCell.self, forCellWithReuseIdentifier: NewsDetailCollectionViewCell.identifier)

        sliderCollectionView.register(NewsDetailCollectionViewCell.self, forCellWithReuseIdentifier: NewsDetailCollectionViewCell.identifier)
    }
}
