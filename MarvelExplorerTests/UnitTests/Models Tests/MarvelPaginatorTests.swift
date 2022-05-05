//
//  MarvelPaginatorTests.swift
//  MarvelExplorerTests
//
//  Created by Mostfa on 04/05/2022.
//

import XCTest
import Combine
@testable import MarvelExplorer
@testable import MarvelExplorerData

class MarvelPaginatorTests: XCTestCase {

  func test_paginator_hasPages() {
    // given/when
    let sut = MarvelPaginator<String>.init(limit: 100,
                                           count: 20,
                                           offset: 40,
                                           total: 100,
                                           results: [])

    // Then
    XCTAssertTrue(sut.hasPages, "paginator should return more pages since offset + count < total")
  }

  func test_paginator_nextOffset_whenHasPages() {
    // given/when
    let sut = MarvelPaginator<String>.init(limit: 100,
                                           count: 20,
                                           offset: 40,
                                           total: 100,
                                           results: [])

    // Then
    XCTAssertEqual(sut.nextOffset, 40 + 100, "paginator should return next offset to be equal to offset+ limit, since it has more pages")
  }

  func test_paginator_nextOffset_whenLimitIsReached() {
    // given/when
    let sut = MarvelPaginator<String>.init(limit: 100,
                                           count: 40,
                                           offset: 60,
                                           total: 100,
                                           results: [])

    // Then
    XCTAssertEqual(sut.nextOffset, 60, "paginator should return next offset to be equal to offset, since it reached the limit of pages")
  }
}
