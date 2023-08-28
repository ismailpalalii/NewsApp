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
                    layout.scrollDirection = .horizontal
                    let collectionView = UICollectionView(frame: .zero,
                                                          collectionViewLayout: layout)
                    collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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

        setTableView()
        setCollectionView()
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

        let category = viewModel.allCategories[viewModel.allCategories.index(viewModel.allCategories.startIndex, offsetBy: indexPath.row)]
        cell.setCategorylist(title: category.rawValue)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let cellWidth = collectionView.frame.width / 3
            let cellHeight: CGFloat = 60
            return CGSize(width: cellWidth, height: cellHeight)
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

        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }

    func goDetailScreen(with viewController: UIViewController) {
        pushViewController(with: viewController)
    }
}
