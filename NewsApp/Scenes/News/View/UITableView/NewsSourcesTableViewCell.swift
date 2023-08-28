//
//  NewsSourcesTableViewCell.swift
//  NewsApp
//
//  Created by İsmail Palalı on 27.08.2023.
//

import UIKit

final class NewsSourcesTableViewCell: UITableViewCell {

    static let identifier: String = "NewsSourcesTableViewCell"
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var descLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Cell Configure
    private func configure() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)

        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.textColor = .blue
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)

        descLabel.numberOfLines = 0
        descLabel.textAlignment = .left
        descLabel.textColor = .black
        descLabel.font = UIFont.boldSystemFont(ofSize: 12)
        descLabel.sizeToFit()

        // MARK: - Constraints
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
        }

        descLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
    }

    // MARK: Set source item
    func setSourcelist(title: String, desc: String) {
        titleLabel.text = title
        descLabel.text = desc
    }
}
