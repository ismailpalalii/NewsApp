//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by İsmail Palalı on 30.08.2023.
//

import UIKit

final class NewsDetailViewController: BaseViewController {
    // MARK: Create UI items
     var sourceTitle: String?
     var sourceID: String?

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
    }
}
