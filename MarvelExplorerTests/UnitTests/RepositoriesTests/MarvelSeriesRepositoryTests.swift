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
@testable import MarvelExplorerData
@testable import MarvelExplorerDomain
@testable import MarvelExplorerUI

class MarvelSeriesRepositoryTests: XCTestCase {

  private let networkService = NetworkServiceTypeMock()
  // TODO: - Repository should be Interface, not concrete type.
  private var repository: DefaultMarvelSeriesRepository!
  private var cancellableBag: [AnyCancellable] = []

  override func setUpWithError() throws {
    repository = DefaultMarvelSeriesRepository.init(networkService: networkService)
  }

  override func tearDownWithError() throws {
  }

  /// tests that a failure is sent to clients of repository in case of invalid response
  func test_fetchSeriesFails_onNetworkError() async throws {
    // Given
    var result: [Series]?
    networkService.responses["/v1/public/series"] = NetworkError.invalidResponse

    // When
    do {
      result = try await repository.fetchSeries()
      XCTFail("An error should be thrown")
    } catch let error {
      XCTAssertNotNil(error)
    }

  }

  /// tests that a success is sent to clients of repository in case of valid response.
  func test_fetchSeriesSucceeds() async throws {
    // Given
    let result: [Series]?

    let series = MarvelSeriesDTOResponse.loadFromFile("SeriesResponse.json")
    networkService.responses["/v1/public/series"] = series

    // When
    result = try await repository.fetchSeries()

    // Then
    XCTAssertNotNil(result, "Result should be available")

  }

  /// Tests that a paginator is set in repository after making first call, which is lated used to load more pages note: pagination responsibility is removed from ViewModel to reduce it’s responsibility.
  func test_fetchSeriesPaginatorNotNil() async throws {
    // Given
    let series = MarvelSeriesDTOResponse.loadFromFile("SeriesResponse.json")
    networkService.responses["/v1/public/series"] = series

    // When
    try await _ = repository.fetchSeries()

    // Then
    XCTAssertNotNil(repository.seriesPaginator, "After first fetch, paginator should contain value")
  }

  /// Tests that next offset is aligned with expected values.
  func test_fetchSeriesPagination_isCorrect() async throws {
    // Given
    let series = MarvelSeriesDTOResponse.loadFromFile("SeriesResponse.json")
    networkService.responses["/v1/public/series"] = series

    // When
    try await _ = repository.fetchSeries()

    // Then
    XCTAssertEqual(repository.seriesPaginator?.nextOffset, 20)
  }

}
