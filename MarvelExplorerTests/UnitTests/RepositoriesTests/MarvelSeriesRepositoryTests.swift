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
  
  
  /// When Fetching we need pagination data for next pages
  func test_fetchSeriesPagination_isCorrect() {
    // Given
    let expectation = self.expectation(description: "Series Pagination")
    let series = MarvelSeriesDTOResponse.loadFromFile("SeriesResponse.json")
    networkService.responses["/v1/public/series"] = series
    
    // When
    repository.fetchSeries()
      .sink { value in
        expectation.fulfill()
      }.store(in: &cancellableBag)
    
    // Then
    self.waitForExpectations(timeout: 1.0, handler: nil)
    
    
    XCTAssertEqual(repository.seriesPaginator?.nextOffset, 20)
  }
  
}
