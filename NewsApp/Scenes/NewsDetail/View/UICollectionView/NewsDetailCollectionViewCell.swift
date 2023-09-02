//
//  NewsDetailCollectionViewCell.swift
//  NewsApp
//
//  Created by İsmail Palalı on 30.08.2023.
//
import UIKit
import SnapKit
import Kingfisher

final class NewsDetailCollectionViewCell: UICollectionViewCell {

    // MARK: Cell identifier
    static let identifier: String = "NewsDetailCollectionViewCell"

    // MARK: Create UI items
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        if #available(iOS 13.0, *) {
            label.textColor = .label
        } else {
            label.textColor = .black
        }
        return label
    }()

    private let newsDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = .black
        return label
    }()

     let saveButton: UIButton = {
         let button = UIButton(type: .system)
        return button
    }()

    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        return view
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Cell Configure
    private func configure() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsDateLabel)
        contentView.addSubview(saveButton)
        contentView.addSubview(lineView)

        newsTitleLabel.font = UIFont.boldSystemFont(ofSize: 10)
        newsDateLabel.font = UIFont.boldSystemFont(ofSize: 9)
        // MARK: - Constraints
        newsImageView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.70)
            make.width.equalToSuperview().multipliedBy(0.95)
        }

        newsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(newsImageView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.width.equalToSuperview().multipliedBy(0.80)
        }

        saveButton.snp.makeConstraints { make in
            make.top.equalTo(newsTitleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(2)
        }

        newsDateLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-32)
            make.top.equalTo(saveButton.snp.bottom).offset(2)
        }

        lineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.width.equalToSuperview()
        }
    }

    // MARK: Set news detail items
    func setNewsDetail(_ news: Article?, isSaved: Bool = false) {
        guard let newsPosterPath = news?.urlToImage, let imageUrl = URL(string: newsPosterPath) else {
            return
        }
        newsImageView.kf.setImage(with: imageUrl)
        newsTitleLabel.text = news?.title
        newsDateLabel.text = news?.formattedPublishedDate()
    }
}
