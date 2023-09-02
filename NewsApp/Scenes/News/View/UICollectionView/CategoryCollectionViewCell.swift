//
//  CategoryCollectionViewCell.swift
//  NewsApp
//
//  Created by İsmail Palalı on 28.08.2023.
//

import UIKit
import SnapKit

final class CategoryCollectionViewCell: UICollectionViewCell {

    // MARK: Cell identifier
    static let identifier: String = "CategoryCollectionViewCell"

    // MARK: Create UI items
    private lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "plus")
        imageView.tintColor = .black
        return imageView
    }()

    private let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = .black
        return label
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Cell Configure
    private func configure() {
        contentView.addSubview(categoryImageView)
        contentView.addSubview(categoryTitleLabel)

        categoryTitleLabel.font = UIFont.boldSystemFont(ofSize: 9)
        categoryTitleLabel.sizeToFit()

        // MARK: - Constraints
        categoryImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        categoryTitleLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }

    // MARK: Set select image
    func setCheckmark(_ isSelected: Bool) {
        if isSelected {
            categoryImageView.image = UIImage(named: "checkmark")
        } else {
            categoryImageView.image = UIImage(named: "plus")
        }
    }

    // MARK: Set category item
    func setCategorylist(title: String) {
        categoryTitleLabel.text = title
    }
}
