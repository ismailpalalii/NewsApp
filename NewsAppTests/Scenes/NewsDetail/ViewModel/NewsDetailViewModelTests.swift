//
//  NewsDetailViewModelTests.swift
//  NewsAppTests
//
//  Created by İsmail Palalı on 1.09.2023.
//

import XCTest
@testable import NewsApp

final class NewsDetailViewModelTests: XCTestCase {

    var viewModel: NewsDetailViewModel!
    var mockService: MockNetworkService!

    override func setUp() {
        super.setUp()
        // MARK: - Setup
        // Initialize NewsDetailViewModel using MockNetworkService
        mockService = MockNetworkService()
        viewModel = NewsDetailViewModel(service: mockService)
    }

    override func tearDown() {
        // MARK: - Teardown
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testGetNewsSource() {
        // MARK: - Test Get Detail List
        // Specify that the mock service should return fake data
        mockService.shouldReturnFakeData = true

        // Call the getNewsDetailList() method
        viewModel.getNewsDetailList()

        // Check the results
        XCTAssertEqual(viewModel.sourceDetailList.count, 4) // Expecting 4 fake news items
        XCTAssertEqual(viewModel.topNews.count, 3) // Expecting 3 fake slide news items

    }

    func testGetNewsSourceError() {
        // MARK: - Test Get Detail List  Error
        // Specify that the mock service should return an error
        mockService.shouldReturnFakeData = false

        // Call the getNewsDetailList() method
        viewModel.getNewsDetailList()

        // Check the results
        XCTAssertEqual(viewModel.sourceDetailList.count, 0) // Since there's no fake data, the source list should be empty
        XCTAssertEqual(viewModel.topNews.count, 0) // Since there's no fake data, the source
    }
}
