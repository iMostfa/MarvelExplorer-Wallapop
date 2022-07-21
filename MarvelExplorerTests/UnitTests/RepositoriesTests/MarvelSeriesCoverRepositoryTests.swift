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
@testable import MarvelExplorerData
@testable import MarvelExplorerDomain

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
  func test_loadsImageFromNetwork() async throws {
    // Given
    let allSeries = MarvelSeriesDTOResponse.loadFromFile("SeriesResponse.json")
    let series = allSeries.data.results.first!
    var result: UIImage?

    imageLoaderService.loadImageReturnValue = UIImage()

    // When
   let image = try await repository
      .loadSeriesCover(with: series.thumbnail.path + series.thumbnail.thumbnailExtension)

    result = image
    // Then
    XCTAssertNotNil(result)
  }

}
