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

    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = .label
        return label
    }()

    private let newsDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = .label
        return label
    }()

    let saveButton: UIButton = {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Okuma Listeme Ekle", for: .normal)
            button.addTarget(NewsDetailCollectionViewCell.self, action: #selector(saveButtonTapped), for: .touchUpInside)
            return button
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

        newsTitleLabel.font = UIFont.boldSystemFont(ofSize: 9)
        newsTitleLabel.sizeToFit()

        newsDateLabel.font = UIFont.boldSystemFont(ofSize: 6)
        newsTitleLabel.sizeToFit()

        // MARK: - Constraints
        newsImageView.snp.makeConstraints { make in
            make.right.left.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(4)
            make.height.equalToSuperview().multipliedBy(0.60)
            make.width.equalToSuperview()
        }

        newsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(newsImageView.snp.bottom).offset(8)
        }

        saveButton.snp.makeConstraints { make in
            make.top.equalTo(newsTitleLabel.snp.bottom).offset(8)
        }

        newsDateLabel.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom).offset(4)
            make.right.equalToSuperview().offset(4)
        }
    }

    // MARK: Save news item
    @objc func saveButtonTapped() {
            print("Button Tapped!")
        }

    // MARK: Set news detail items

    func setNewsDetail(_ news: Article) {
       guard let newsPosterPath = news.urlToImage else {
           return
       }
       guard let imageUrl = URL(string: "\(newsPosterPath)") else {
           return
       }
       DispatchQueue.main.async {
           self.newsImageView.kf.setImage(with: imageUrl)
           self.newsTitleLabel.text = news.title
           //self.newsDateLabel.text = news.publishedAt.toString(format: "dd.MM.yyyy")
       }
   }
}
