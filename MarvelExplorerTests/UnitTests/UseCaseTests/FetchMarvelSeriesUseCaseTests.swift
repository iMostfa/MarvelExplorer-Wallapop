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

class FetchMarvelSeriesUseCaseTests: XCTestCase {
  
  private let repository = MarvelSeriesRepositoryMock.init()
  private var useCase: DefaultFetchMarvelSeriesUseCase!
  private var cancellableBag: [AnyCancellable] = []
  
  override func setUpWithError() throws {
    useCase = .init(seriesRepository: repository)
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
    
  
  /// Tests that data is retuned from repository succeeds.
  func test_fetchSeriesDomainsSucceeds() {
    // Given
    var result: Result<[Series], Error>!
    let expectation = self.expectation(description: "Series Fetching")
    let series = MarvelSeriesDTOResponse.loadFromFile("SeriesResponse.json")
    repository.searchSeriesReturnValue = .just(Result<[Series],Error>.success(series.data.results.map { $0.toDomain() }))
    
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
  
}
