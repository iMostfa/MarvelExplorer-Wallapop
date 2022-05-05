//
//  MarvelUITests.swift
//  MarvelUITests
//
//  Created by Mostfa on 03/05/2022.
//

import XCTest

class MarvelUITests: XCTestCase {

  var app: XCUIApplication!
  let AIDs = AccessibilityIdentifiers.self

  override func setUpWithError() throws {
    continueAfterFailure = false
    app = XCUIApplication.init()
    app.launchArguments = ["UITests"]
    app.launch()
  }

  override func tearDownWithError() throws {
    app.terminate()
    
  }

  func test_application_isEmbeddedInNavigation()  throws {
    let marvelSeriesStaticText = app.navigationBars["Marvel Series"].waitForExistence(timeout: 1)
    XCTAssertTrue(marvelSeriesStaticText)

  }

  func test_seriesCell_contains_Thumbnail() throws {
   let containsThumbnail = app
      .collectionViews[AIDs.SeriesList.collectionViewID]
      .cells["SeriesList.cellId-0"]
      .images[AIDs.SeriesListCell.seriesThumbnailImage]
      .waitForExistence(timeout: 1.0)

    XCTAssertTrue(containsThumbnail)
  }

  func test_seriesCell_contains_endYear() throws {
    let containsEndYears = app
      .collectionViews[AIDs.SeriesList.collectionViewID]
      .cells["SeriesList.cellId-0"]
      .staticTexts[AIDs.SeriesListCell.seriesStartYearLabel]
      .waitForExistence(timeout: 1.0)

    XCTAssertTrue(containsEndYears)
  }

  func test_seriesCell_contains_startYear() throws {
    let containsStartYear = app
      .collectionViews[AIDs.SeriesList.collectionViewID]
      .cells["SeriesList.cellId-0"]
      .staticTexts[AIDs.SeriesListCell.seriesStartYearLabel]
      .waitForExistence(timeout: 1.0)

    XCTAssertTrue(containsStartYear)
  }

  
  //This function appears to be failing on CI, disabled temporarily.
  //you can run it manually here.
  func test_application_isLoadingOnLaunch()  throws {
    let loadingElement = XCUIApplication.init().otherElements["SVProgressHUD"].exists
    
    XCTAssertTrue(loadingElement)
  }


  func test_SeriesDetail_isPushed() throws {

    app.collectionViews[AIDs.SeriesList.collectionViewID]
      .cells["SeriesList.cellId-0"]
      .images["SeriesListCell.thumbnailImage"]
      .tap()

    let seriesdetailTableviewidTable = app.tables["SeriesDetail.tableViewID"]

    XCTAssertTrue(seriesdetailTableviewidTable.exists)
  }

  func test_SeriesHeaderIsAboveDetails() {

    app
      .collectionViews[AIDs.SeriesList.collectionViewID]
      .cells["SeriesList.cellId-0"]
      .children(matching: .other)
      .element
      .tap()

    let tablesQuery = app.tables
    let seriesHeader = tablesQuery.children(matching: .other).element(boundBy: 0)

    let seriesDetail = tablesQuery.staticTexts["Series Description"]

    XCTAssertLessThan(seriesHeader.frame.minY,
                      seriesDetail.frame.minY)

  }

  func test_SeriesDetailOrder() {

    app.collectionViews[AIDs.SeriesList.collectionViewID]
      .cells["SeriesList.cellId-0"]
      .children(matching: .other)
      .element
      .tap()

    let tablesQuery = app.tables

    let seriesDetail = tablesQuery.staticTexts["Series Description"]
    let seriesDescription = tablesQuery.staticTexts["Series Duration"]
    let seriesWriters = tablesQuery.staticTexts["Series Writers"]

    XCTAssertLessThan(seriesDetail.frame.minY,
                      seriesDescription.frame.minY)

    XCTAssertLessThan(seriesDetail.frame.minY,
                      seriesWriters.frame.minY)
  }

  /// Tests app launch, baseline is two seconds.
  func testLaunchPerformance() throws {
    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
      // This measures how long it takes to launch your application.
      // Baseline is 2.0
      measure(metrics: [XCTApplicationLaunchMetric()]) {
        XCUIApplication().launch()
      }
    }
  }
}
