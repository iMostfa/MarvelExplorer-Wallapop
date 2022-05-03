//
//  MarvelSeriesRepositoryMock.swift
//  MarvelExplorerTests
//
//  Created by Mostfa on 01/05/2022.
//

import Foundation
import XCTest
import Combine
@testable import MarvelExplorer


class MarvelSeriesRepositoryMock: MarvelSeriesRepository {

  var fetchSeriesCallsCount = 0
  
  var serachSeriesWasCalled: Bool {
    return fetchSeriesCallsCount > 0
  }
  
  var searchSeriesReturnValue: AnyPublisher<Result<[Series], Error>, Never>!
  var searchSeriesClosure: (() -> AnyPublisher<Result<[Series], Error>, Never>)?
  
  func fetchSeries() -> AnyPublisher<Result<[Series], Error>, Never> {
    fetchSeriesCallsCount += 1
    return searchSeriesReturnValue
  }
  
  
}
