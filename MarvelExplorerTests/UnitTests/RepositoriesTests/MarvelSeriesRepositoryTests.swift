//
//  FetchMarvelSeriesUseCaseTests.swift
//  MarvelExplorerTests
//
//  Created by Mostfa on 01/05/2022.
//

import Foundation
import XCTest
import Combine
@testable import MarvelExplorer


class MarvelSeriesRepositoryTests: XCTestCase {
  
  private let networkService = NetworkServiceTypeMock()
  private var repository: DefaultMarvelSeriesRepository!
  private var cancellableBag: [AnyCancellable] = []
  
  override func setUpWithError() throws {
    repository = DefaultMarvelSeriesRepository.init(networkService: networkService)
  }
  
  override func tearDownWithError() throws {
  }
  
  func test_searchSeriesQuery_inTitle() {
    // Given
    var result: Result<[Series], Error>!
    let expectation = self.expectation(description: "Series Fetching")
    let series = MarvelSeriesDTOResponse.loadFromFile("FilteredSeries.json")
    networkService.responses["/v1/public/series"] = series
    let query = "Superior"
    // When
    
    ///* filterSeries(query:) Currently depend on the already fetched Series, which means we need to fetch series before anything else, we may want to decouple that. */
    repository
      .fetchSeries()
      .flatMap { _ in self.repository.filterSeries(query: query) }
      .sink { value in
      result = value
      expectation.fulfill()
    }.store(in: &cancellableBag)
    
    // Then
    self.waitForExpectations(timeout: 1.0, handler: nil)
    guard case .success(let items) = result! else {
      XCTFail("Result Should Be success")
      return
    }
        XCTAssertEqual(items.count, 1)
  }
  
  func test_searchSeriesQuery_inYear() {
    // Given
    var result: Result<[Series], Error>!
    let expectation = self.expectation(description: "Series Fetching")
    let series = MarvelSeriesDTOResponse.loadFromFile("FilteredSeries.json")
    networkService.responses["/v1/public/series"] = series
    let query = "2019"
    // When
    
    ///* filterSeries(query:) Currently depend on the already fetched Series, which means we need to fetch series before anything else, we may want to decouple that. */
    repository
      .fetchSeries()
      .flatMap { _ in self.repository.filterSeries(query: query) }
      .sink { value in
        result = value
        expectation.fulfill()
      }.store(in: &cancellableBag)
    
    // Then
    self.waitForExpectations(timeout: 1.0, handler: nil)
    guard case .success(let items) = result!, let firstSeries = items.first else {
      XCTFail("Result Should Be success")
      return
    }
    XCTAssertEqual(firstSeries.id, 26024)
  }
  
  
  func test_fetchSeriesFails_onNetworkError() {
    // Given
    var result: Result<[Series], Error>!
    let expectation = self.expectation(description: "Series Fetching")
    networkService.responses["/v1/public/series"] = NetworkError.invalidResponse
    
    // When
    repository.fetchSeries().sink { value in
      result = value
      expectation.fulfill()
    }.store(in: &cancellableBag)

    // Then
    self.waitForExpectations(timeout: 1.0, handler: nil)
    guard case .failure = result! else {
      XCTFail("Result Should Be success")
      return
    }
  }
  
  func test_fetchSeriesSucceeds() {
    // Given
    var result: Result<[Series], Error>!
    let expectation = self.expectation(description: "Series Fetching")
    let series = MarvelSeriesDTOResponse.loadFromFile("SeriesResponse.json")
    networkService.responses["/v1/public/series"] = series
    
    // When
    repository.fetchSeries().sink { value in
      result = value
      expectation.fulfill()
    }.store(in: &cancellableBag)
    
    // Then
    self.waitForExpectations(timeout: 1.0, handler: nil)
    guard case .success = result! else {
      XCTFail("Result Should Be success")
      return
    }
  }
  
  func test_fetchSeriesPaginatorNotNil() {
    // Given
    let expectation = self.expectation(description: "Series Pagination")
    let series = MarvelSeriesDTOResponse.loadFromFile("SeriesResponse.json")
    networkService.responses["/v1/public/series"] = series
    
    // When
    repository.fetchSeries().sink { value in
      expectation.fulfill()
    }.store(in: &cancellableBag)
    
    // Then
    self.waitForExpectations(timeout: 1.0, handler: nil)
    XCTAssertNotNil(repository.seriesPaginator, "After first fetch, paginator should contain value")
  }
  
  /// When Fetching one more page, we should receive a new page along to the old page.
  func test_fetchSeriesPagination_afterTwoCalls() {
    // Given
    let expectation = self.expectation(description: "Series Pagination")
    let series = MarvelSeriesDTOResponse.loadFromFile("SeriesResponse.json")
    networkService.responses["/v1/public/series"] = series
    var result: Result<[Series], Error>!
    
    // When
    repository.fetchSeries()
      .flatMap {_ in self.repository.fetchSeries() } // Fetch Series is called two times, which should return twice the number of elements
      .sink { value in
        result = value
        expectation.fulfill()
      }.store(in: &cancellableBag)
    
    // Then
    self.waitForExpectations(timeout: 1.0, handler: nil)
    guard case .success(let items) = result! else {
      XCTFail("Result Should Be success")
      return
    }
    
    XCTAssertEqual(items.count, series.data.count * 2)
  }
  
  
  func test_fetchSeriesPagination_isAddedToOldSeries() {
    // Given
    let expectation = self.expectation(description: "Series Pagination")
    let series = MarvelSeriesDTOResponse.loadFromFile("SeriesResponse.json")
    let secondPageSeries = MarvelSeriesDTOResponse.init(code: 200,
                                                         status: "", data: .init(limit: 0, count: 20, offset: 20, total: 1230, results: series.data.results.reversed()))

    networkService.responses["/v1/public/series"] = series
    var result: Result<[Series], Error>!

    // When
    repository.fetchSeries()
      .handleEvents(receiveOutput: { _ in
        self.networkService.responses["/v1/public/series"] = secondPageSeries
        
      })
      .flatMap {_ in self.repository.fetchSeries() } // Fetch Series is called the second time, which should return one more page the number of elements
      .sink { value in
        result = value
      expectation.fulfill()
    }.store(in: &cancellableBag)
    
    // Then
    self.waitForExpectations(timeout: 1.0, handler: nil)
    guard case .success(let items) = result! else {
      XCTFail("Result Should Be success")
      return
    }
    let expectedSeries = (series.data.results + secondPageSeries.data.results)
      .map { $0.toDomain() }
   
    XCTAssertEqual(items, expectedSeries)
  }
  
}

