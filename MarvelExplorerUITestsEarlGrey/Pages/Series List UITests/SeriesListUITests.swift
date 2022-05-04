//
//  SeriesListUITests.swift
//  MarvelExplorerTests
//
//  Created by Mostfa on 02/05/2022.
//

import XCTest

@testable import MarvelExplorer

class MarvelSeriesListUITests: MarvelExplorerTestCase {
  
  let seriesListNavigatorMock = SeriesListNavigatorMock()

  
  override func setUpWithError() throws {
    
  }
  
  func test_showDetails_whenTapOnItem() {
    // GIVEN
    let seriesDTO = MarvelSeriesDTOResponse.loadFromFile("SeriesResponse.json")
    self.seriesRepository.searchSeriesReturnValue = .just(.success(seriesDTO.data.results.map { $0.toDomain() }))
    self.seriesCoversRepository.loadSeriesCoverReturnValue = .just(.init())
    open(viewController: factory.seriesListNavigationController(navigator: seriesListNavigatorMock))
    
    // WHEN
    Page.on(SeriesListPage.self)
      .search("Fant")
      .tapItem(at: 0)
    
    // THEN
    XCTAssertTrue(seriesListNavigatorMock.showDetailsForSeriesCalled)
  }
  
  func test_SeriesUpdatedInCollectionView() {
    // GIVEN
    let seriesDTO = MarvelSeriesDTOResponse.loadFromFile("SeriesResponse.json")
    open(viewController: factory.seriesListNavigationController(navigator: SeriesListNavigatorMock.init()))
    self.seriesRepository.searchSeriesReturnValue = .just(.success(seriesDTO.data.results.map { $0.toDomain() }))
    self.seriesCoversRepository.loadSeriesCoverReturnValue = .just(.init())

    // When/THEN
    Page.on(SeriesListPage.self).assertSeriessCount(seriesDTO.data.results.count)
  }
  
  func test_initialStateTitle() {
    // GIVEN /WHEN
    open(viewController: self.factory.seriesListNavigationController(navigator: seriesListNavigatorMock))
    
    
    //When
    self.seriesRepository.searchSeriesReturnValue = .empty()

    
    //Then
        Page.on(SeriesListPage.self)
      .assertScreenTitle("Marvel Series")
  }
  
  
}
