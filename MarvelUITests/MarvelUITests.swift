//
//  MarvelUITests.swift
//  MarvelUITests
//
//  Created by Mostfa on 03/05/2022.
//

import XCTest

class MarvelUITests: XCTestCase {

  var app: XCUIApplication!

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    app = XCUIApplication.init()
    app.launch()
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test_application_isEmbeddedInNavigation()  throws {
    // Tests that the home screen is embedded in navigation.
    let marvelSeriesStaticText = XCUIApplication().navigationBars["Marvel Series"].waitForExistence(timeout: 1)
    XCTAssertTrue(marvelSeriesStaticText)

  }

  func test_application_isLoadingOnLaunch()  throws {
    let loadingElement = app.otherElements["SVProgressHUD"]
    XCTAssertTrue(loadingElement.exists)
  }

  func test_SeriesDetail_isPushed() throws {
    // given
    app
      .collectionViews[AccessibilityIdentifiers.SeriesList.collectionViewID]
      .cells["SeriesList.cellId-1"]
      .children(matching: .other)
      .element.tap()
    // when
    let isSeriesDetailShown = app.tables.staticTexts["Series Description"].exists

    // then
    XCTAssertTrue(isSeriesDetailShown)
  }

  func test_SeriesHeaderIsAboveDetails() {

    app
      .collectionViews[AccessibilityIdentifiers.SeriesList.collectionViewID]
      .cells["SeriesList.cellId-1"]
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

    app.collectionViews[AccessibilityIdentifiers.SeriesList.collectionViewID]
      .cells["SeriesList.cellId-1"]
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
      measure(metrics: [XCTApplicationLaunchMetric()]) {
        XCUIApplication().launch()
      }
    }
  }
}
