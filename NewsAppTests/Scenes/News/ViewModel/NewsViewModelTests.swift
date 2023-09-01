//
//  NewsViewModelTests.swift
//  NewsAppTests
//
//  Created by İsmail Palalı on 26.08.2023.
//

import XCTest
@testable import NewsApp

final class NewsViewModelTests: XCTestCase {

    var viewModel: NewsViewModel!
    var mockService: MockNetworkService!

    override func setUp() {
        super.setUp()
        // MARK: - Setup
        // Initialize NewsViewModel using MockNetworkService
        mockService = MockNetworkService()
        viewModel = NewsViewModel(service: mockService)
    }

    override func tearDown() {
        // MARK: - Teardown
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testGetNewsSource() {
        // MARK: - Test Get News Source
        // Specify that the mock service should return fake data
        mockService.shouldReturnFakeData = true

        // Call the getNewsSource() method
        viewModel.getNewsSource()

        // Check the results
        XCTAssertEqual(viewModel.sourceList.count, 3) // Expecting 3 fake news items
        XCTAssertEqual(viewModel.allCategories.count, 2) // Expected category count
        XCTAssertTrue(viewModel.selectedCategories.isEmpty) // There should be no selected categories initially
    }

    func testGetNewsSourceError() {
        // MARK: - Test Get News Source Error
        // Specify that the mock service should return an error
        mockService.shouldReturnFakeData = false

        // Call the getNewsSource() method
        viewModel.getNewsSource()

        // Check the results
        XCTAssertEqual(viewModel.sourceList.count, 0) // Since there's no fake data, the source list should be empty
        XCTAssertEqual(viewModel.allCategories.count, 0) // The category list should also be empty
        XCTAssertTrue(viewModel.selectedCategories.isEmpty) // There should be no selected categories initially
    }
}
