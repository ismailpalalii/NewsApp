//
//  NewsViewController.swift
//  NewsApp
//
//  Created by İsmail Palalı on 27.08.2023.
//

import UIKit
import SnapKit

// MARK: NewsViewDelegate
protocol NewsViewDelegate: BaseViewDelegate {
    func setTableView()
    func setCollectionView()
    func reloadData()
    func goDetailScreen(_ sourceList: Source)
}

final class NewsViewController: BaseViewController {

    // MARK: Create UI items
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    private lazy var newsSourcesTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 120
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.hidesWhenStopped = true
        return indicator
    }()

    private let refreshControl = UIRefreshControl()

    // MARK: ViewModel
    private var viewModel = NewsViewModel()

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
        title = "Kaynaklar"
        view.backgroundColor = .systemBackground
        view.addSubview(categoryCollectionView)
        view.addSubview(newsSourcesTableView)
        view.addSubview(activityIndicator)

        newsSourcesTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        navigationItem.hidesBackButton = true

        // MARK: Constraints
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(100)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }

        newsSourcesTableView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(32)
            make.bottom.equalToSuperview().offset(8)
            make.width.equalToSuperview()
        }

        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    // MARK: Pull to refresh source list data
    @objc private func refreshData() {
        viewModel.getNewsSource()
    }
}

// MARK: UITableView Delegate
extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sourceList.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = newsSourcesTableView.dequeueReusableCell(withIdentifier: NewsSourcesTableViewCell.identifier, for: indexPath) as? NewsSourcesTableViewCell else { return UITableViewCell() }

        cell.setSourcelist(title: viewModel.sourceList[indexPath.row].name ?? "",
                           desc:  viewModel.sourceList[indexPath.row].description ?? "")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItemAtTableview(indexPath)
    }
}

// MARK: UICollectionView Delegate
extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.allCategories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.lightGray.cgColor

        let categoryArray = Array(viewModel.allCategories)
        let selectedCategory = categoryArray[indexPath.row]
        cell.setCategorylist(title: selectedCategory.rawValue)

        let isSelected = viewModel.isCategorySelected(selectedCategory)
        cell.setCheckmark(isSelected)
        cell.backgroundColor = isSelected ? UIColor.lightGray : UIColor.white

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width / 3
        let cellHeight: CGFloat = 60
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = viewModel.allCategories[indexPath.row]
        viewModel.toggleCategorySelection(selectedCategory)
        collectionView.reloadData()
    }
}

// MARK: NewsViewDelegate Delegate
extension NewsViewController: NewsViewDelegate {
    func reloadData() {
        categoryCollectionView.reloadData()
        newsSourcesTableView.reloadData()

        activityIndicator.stopAnimating()
        refreshControl.endRefreshing()
    }

    func setTableView() {
        newsSourcesTableView.delegate = self
        newsSourcesTableView.dataSource = self

        newsSourcesTableView.register(NewsSourcesTableViewCell.self, forCellReuseIdentifier: NewsSourcesTableViewCell.identifier)
    }

    func setCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self

        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }

    func goDetailScreen(_ sourceList: Source) {
        let controller = NewsDetailViewController(sourceTitle: sourceList.name, sourceID: sourceList.id)
        navigationController?.pushViewController(
            controller,
            animated: true
        )
    }
}
