//
//  ImageLoaderRepository.swift
//  MarvelExplorerTests
//
//  Created by Mostfa on 01/05/2022.
//

import Foundation
import XCTest
import Combine
@testable import MarvelExplorer

class MarvelSeriesCoverRepositoryMockTests: XCTestCase {

  private let imageLoaderService = ImageLoaderServiceTypeMock()
  private var repository: MarvelSeriesCoverRepository!
  private var cancellableBag: [AnyCancellable] = []

  override func setUpWithError() throws {
    repository = DefaultMarvelSeriesCoverRepository.init(imageLoader: imageLoaderService)
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  /// Tests that an image is returned.
  func test_loadsImageFromNetwork() {
    // Given
    let allSeries = MarvelSeriesDTOResponse.loadFromFile("SeriesResponse.json")
    let series = allSeries.data.results.first!
    var result: UIImage?
    let expectation = self.expectation(description: "image Loader")

    imageLoaderService.loadImageReturnValue = .just(UIImage())

    // When
    repository
      .loadSeriesCover(with: series.thumbnail.path + series.thumbnail.thumbnailExtension)
      .sink { value in
        result = value
        expectation.fulfill()
      }.store(in: &cancellableBag)

    // Then
    self.waitForExpectations(timeout: 1.0, handler: nil)
    XCTAssertNotNil(result)
  }

}
