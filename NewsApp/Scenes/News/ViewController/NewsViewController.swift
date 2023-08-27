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
    func reloadData()
    func goDetailScreen(with viewController: UIViewController)
}

final class NewsViewController: BaseViewController {

    // MARK: Create UI items
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
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

    private var viewModel = NewsViewModel()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getNewsSource()
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

        navigationItem.hidesBackButton = true

        // MARK: Constraints
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(200)
            make.width.equalToSuperview()
        }

        newsSourcesTableView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(8)
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }

        setTableView()
        setCollectionView()
    }
}

// MARK: UITableView Delegate
extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sourceList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = newsSourcesTableView.dequeueReusableCell(withIdentifier: NewsSourcesTableViewCell.identifier, for: indexPath) as? NewsSourcesTableViewCell else { return UITableViewCell() }

        cell.setSourcelist(title: viewModel.sourceList?[indexPath.row].name ?? "",
                           desc:  viewModel.sourceList?[indexPath.row].description ?? "")
        return cell
    }
}

// MARK: UICollectionView Delegate
extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.allCategories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

// MARK: NewsViewDelegate Delegate
extension NewsViewController: NewsViewDelegate {
    func reloadData() {
        categoryCollectionView.reloadData()
        newsSourcesTableView.reloadData()
    }

    func setTableView() {
        newsSourcesTableView.delegate = self
        newsSourcesTableView.dataSource = self

        newsSourcesTableView.register(NewsSourcesTableViewCell.self, forCellReuseIdentifier: NewsSourcesTableViewCell.identifier)
    }

    func setCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }

    func goDetailScreen(with viewController: UIViewController) {
        pushViewController(with: viewController)
    }
}
