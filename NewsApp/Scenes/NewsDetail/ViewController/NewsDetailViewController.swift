//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by İsmail Palalı on 30.08.2023.
//

import UIKit

final class NewsDetailViewController: BaseViewController {
    // MARK: Create UI items
    private lazy var sliderCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .white
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

    private let refreshControl = UIRefreshControl()

    var sourceTitle: String?
    var sourceID: String?

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
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    // MARK: - UI Configure
    private func configure() {
        title = sourceTitle
        view.backgroundColor = .systemBackground
        view.addSubview(sliderCollectionView)
        view.addSubview(newsListCollectionView)
        view.addSubview(activityIndicator)

        newsListCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        navigationItem.hidesBackButton = true

        // MARK: Constraints
        sliderCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(100)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }

        newsListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sliderCollectionView.snp.bottom).offset(32)
            make.bottom.equalToSuperview().offset(8)
            make.width.equalToSuperview()
        }

        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    // MARK: Pull to refresh source list data
    @objc private func refreshData() {

        }
    }
