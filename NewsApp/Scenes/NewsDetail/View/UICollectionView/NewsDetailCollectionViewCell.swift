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

    let lineView: UIView = {
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
        newsTitleLabel.sizeToFit()

        newsDateLabel.font = UIFont.boldSystemFont(ofSize: 9)
        newsTitleLabel.sizeToFit()

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
            make.left.equalToSuperview().offset(8)
            make.width.equalToSuperview().multipliedBy(0.40)
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
           self.newsDateLabel.text = "02/02/2022"
       }
   }
}
