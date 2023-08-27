//
//  NewsViewController.swift
//  NewsApp
//
//  Created by İsmail Palalı on 27.08.2023.
//

import UIKit
import SnapKit

final class NewsViewController: UIViewController {

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
        tableView.rowHeight = 80
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    // MARK: - UI Configure
    private func configure() {
        title = "Kaynaklar"
        view.backgroundColor = .systemBackground
        view.addSubview(categoryCollectionView)
        view.addSubview(newsSourcesTableView)

        newsSourcesTableView.delegate = self
        newsSourcesTableView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self

        navigationItem.hidesBackButton = true

        // MARK: Constraints
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(80)
            make.width.equalToSuperview()
        }

        newsSourcesTableView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(16)
            make.width.height.equalToSuperview()
        }
    }
}

// MARK: UITableView Delegate
extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: UICollectionView Delegate
extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
