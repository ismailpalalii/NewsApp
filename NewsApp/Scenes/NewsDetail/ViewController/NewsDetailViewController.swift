//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by İsmail Palalı on 30.08.2023.
//

import UIKit
import SnapKit

// MARK: NewsViewDelegate
protocol NewsDetailViewDelegate: BaseViewDelegate {
    func setCollectionView()
    func setSourceID()
    func reloadData()
    func showRetryPopup(title: String, message: String)
    func hideIndicator()
    func showIndicator()
}

final class NewsDetailViewController: BaseViewController {

    // MARK: Create UI items

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var sliderCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()

    private lazy var newsListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        if #available(iOS 13.0, *) {
            return UIActivityIndicatorView(style: .large)
        } else {
            let indicator = UIActivityIndicatorView(style: .whiteLarge)
            indicator.color = .gray
            indicator.hidesWhenStopped = true
            return indicator
        }
    }()

    private lazy var pageController: UIPageControl = {
        let page = UIPageControl()
        page.numberOfPages = 3
        page.currentPage = 0
        page.pageIndicatorTintColor = UIColor.gray
        page.currentPageIndicatorTintColor = UIColor.blue
        return page
    }()

    private lazy var refreshControl = UIRefreshControl()
    private lazy var contentView = UIView()

    var sourceTitle: String?
    var sourceID: String?
    var currentPage = 0
    var pullRefreshCount = 0
    var slideTimer: Timer?
    var autoRefreshTimer: Timer?
    var newsListCount = 0
    var selectedTitle: String?

    // MARK: ViewModel
    private var networkService: NetworkServiceProtocol!
    private var viewModel: NewsDetailViewModel!

    init(sourceTitle: String? = nil, sourceID: String? = nil) {
        self.sourceTitle = sourceTitle
        self.sourceID = sourceID
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: lifeCycleInfo
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
        networkService = NetworkService()
        viewModel = NewsDetailViewModel(service: networkService)
        viewModel.view = self
        viewModel.viewWillAppear()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override var shouldAutorotate: Bool {
      return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
      return [UIInterfaceOrientationMask.landscapeLeft,
              UIInterfaceOrientationMask.landscapeRight,
              UIInterfaceOrientationMask.portrait ];
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAutoScrolling()
    }

    // MARK: - UI Configure
    private func configure() {
        title = sourceTitle
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(sliderCollectionView)
        contentView.addSubview(newsListCollectionView)
        contentView.addSubview(activityIndicator)
        contentView.addSubview(pageController)

        scrollView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        // MARK: Constraints

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.scrollView)
            make.left.right.equalTo(self.view)
            make.width.equalTo(self.scrollView)
            make.height.equalTo(self.scrollView)
        }
        sliderCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.height.equalToSuperview().multipliedBy(0.40)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }

        newsListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(pageController.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }

        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        pageController.snp.makeConstraints { make in
            make.top.equalTo(sliderCollectionView.snp.bottom).offset(-32)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.45)
            make.height.equalToSuperview().multipliedBy(0.05)
        }

        startAutoScrolling()
        setupAutoRefreshTimer()
    }

    // MARK: Start scroll slide
    func startAutoScrolling() {
        slideTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    // MARK: Stop scroll slide
    func stopAutoScrolling() {
        slideTimer?.invalidate()
        slideTimer = nil
    }

    // MARK: Check pullRefreshCount
   func checkAndShowRetryPopup() {
           pullRefreshCount += 1
           if pullRefreshCount % 3 == 0 {
               showRetryPopup(title: "Opsiyonel Hata", message: "Bilgileri alırken bir sorun oluştu. Lütfen tekrar deneyin.")
           } else {
               viewModel.getNewsDetailList()
               reloadData()
           }
       }

    // MARK: Setup timer check new source list
    private func setupAutoRefreshTimer() {
        autoRefreshTimer = Timer.scheduledTimer(
            timeInterval: 60.0,
            target: self,
            selector: #selector(autoRefreshTimerFired),
            userInfo: nil,
            repeats: true
        )
    }

    // MARK: Check new source list
    @objc private func autoRefreshTimerFired() {
        let previousCount = newsListCount
        viewModel.getNewsDetailList()
        if previousCount != viewModel.sourceDetailList.count {
            reloadData()
        } else {
            print("previous list count : \(previousCount) , new list count : \(viewModel.sourceDetailList.count)")
        }
    }

    // MARK: autoScroll
    @objc private func autoScroll() {
        let nextPage = (pageController.currentPage + 1) % pageController.numberOfPages
        pageController.currentPage = nextPage

        let offsetX = CGFloat(nextPage) * sliderCollectionView.bounds.width
        sliderCollectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }

    // MARK: Pull to refresh source list data
    @objc private func refreshData() {
        checkAndShowRetryPopup()
    }

    // MARK: saveSlideItems
    @objc func saveSlideItems(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let selectedNews = viewModel.topNews[indexPath.row]

        viewModel.toggleReadingListStatus(for: selectedNews)
        sliderCollectionView.reloadData()
    }

    // MARK: saveNewsItems
    @objc func saveNewsItems(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let selectedNews = viewModel.sourceDetailList[indexPath.row]

        viewModel.toggleReadingListStatus(for: selectedNews)
        newsListCollectionView.reloadData()
    }
}

// MARK: UICollectionView Delegate
extension NewsDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == sliderCollectionView ? viewModel.topNews.count : viewModel.sourceDetailList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sliderCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsDetailCollectionViewCell.identifier, for: indexPath) as? NewsDetailCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setNewsDetail(viewModel.topNews[indexPath.row])
            cell.saveButton.tag = indexPath.row
            cell.saveButton.addTarget(self, action: #selector(saveSlideItems(_:)), for: .touchUpInside)
            if let data = viewModel.fetchData()?.filter({ $0.title == viewModel.topNews[indexPath.row].title }) {
                if !data.isEmpty {
                    cell.saveButton.setTitle("Okuma Listesinden Çıkar", for: .normal)
                    cell.saveButton.setTitleColor(.black, for: .normal)
                    cell.saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                } else {
                    cell.saveButton.setTitle("Okuma Listesine Ekle", for: .normal)
                    cell.saveButton.setTitleColor(.gray, for: .normal)
                    cell.saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                }

            }
            return cell
        } else if collectionView == newsListCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsDetailCollectionViewCell.identifier, for: indexPath) as? NewsDetailCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setNewsDetail(viewModel.sourceDetailList[indexPath.row])
            cell.saveButton.tag = indexPath.row
            cell.saveButton.addTarget(self, action: #selector(saveNewsItems(_:)), for: .touchUpInside)
            if let data = viewModel.fetchData()?.filter({ $0.title == viewModel.sourceDetailList[indexPath.row].title }) {
                if !data.isEmpty {
                    cell.saveButton.setTitle("Okuma Listesinden Çıkar", for: .normal)
                    cell.saveButton.setTitleColor(.black, for: .normal)
                    cell.saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                } else {
                    cell.saveButton.setTitle("Okuma Listesine Ekle", for: .normal)
                    cell.saveButton.setTitleColor(.gray, for: .normal)
                    cell.saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView == sliderCollectionView ? CGSize(width: collectionView.frame.width, height: collectionView.frame.height) : CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 2 + 100)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageController.currentPage = indexPath.row
    }
}

// MARK: NewsDetailViewDelegate Delegate
extension NewsDetailViewController: NewsDetailViewDelegate {
    func showIndicator() {
        activityIndicator.startAnimating()
    }

    func hideIndicator() {
        activityIndicator.stopAnimating()
    }

    func showRetryPopup(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let retryAction = UIAlertAction(title: "Tekrar Dene", style: .default) { _ in
            self.viewModel.getNewsDetailList()
        }

        let cancelAction = UIAlertAction(title: "Ana Sayfaya Git", style: .default) { _ in
            self.pushViewController(with: NewsViewController())
        }

        alert.addAction(retryAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }

    func setSourceID() {
        viewModel.sourceID = sourceID ?? ""
    }

    func reloadData() {
        sliderCollectionView.reloadData()
        newsListCollectionView.reloadData()

        activityIndicator.stopAnimating()
        refreshControl.endRefreshing()

        newsListCount = viewModel.sourceDetailList.count
    }

    func setCollectionView() {
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self

        newsListCollectionView.delegate = self
        newsListCollectionView.dataSource = self

        newsListCollectionView.register(NewsDetailCollectionViewCell.self, forCellWithReuseIdentifier: NewsDetailCollectionViewCell.identifier)

        sliderCollectionView.register(NewsDetailCollectionViewCell.self, forCellWithReuseIdentifier: NewsDetailCollectionViewCell.identifier)
    }
}
