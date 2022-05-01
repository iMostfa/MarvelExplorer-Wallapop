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
  
  
  //MARK: - Filter Series
  var filterSeriesWithCallsCount = 0
  var filterSeriesWithReceivedQuery: String?
  var filterSeriesWithReceivedInvocations: [String] = []
  var filterSeriesWithReturnValue: AnyPublisher<Result<[Series], Error>, Never>!
  var filterSeriesWithClosure: ((String) -> AnyPublisher<Result<[Series], Error>, Never>)?

  
  func filterSeries(query: String) -> AnyPublisher<Result<[Series], Error>, Never> {

    filterSeriesWithCallsCount += 1
    filterSeriesWithReceivedQuery = query
    filterSeriesWithReceivedInvocations.append(query)
   
    return filterSeriesWithClosure.map({ $0(query) }) ?? filterSeriesWithReturnValue
  }
  
  
}
