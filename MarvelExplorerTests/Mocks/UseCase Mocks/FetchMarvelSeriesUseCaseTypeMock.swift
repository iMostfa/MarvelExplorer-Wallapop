//
//  FetchMarvelSeriesUseCaseTypeMock.swift
//  MarvelExplorerTests
//
//  Created by Mostfa on 01/05/2022.
//

import Foundation
import XCTest
import Combine
@testable import MarvelExplorer


class FetchMarvelSeriesUseCaseTypeMock: FetchMarvelSeriesUseCaseType {
  
  
  //MARK: - fetchSeries
  var fetchSeriesCallsCount = 0
  
  var searchSeriessWasCalled: Bool {
    return fetchSeriesCallsCount > 0
  }
  
  var fetchSeriesReceivedInvocations: [()] = []
  var fetchSeriesReturnValue: AnyPublisher<Result<[Series], Error>, Never>!
  var fetchSeriesWithClosure: (() -> AnyPublisher<Result<[Series], Error>, Never>)?
  
  func fetchSeries() -> AnyPublisher<Result<[Series], Error>, Never> {
    fetchSeriesCallsCount += 1
    fetchSeriesReceivedInvocations.append(())
    return fetchSeriesWithClosure?() ?? fetchSeriesReturnValue
  }
  
  
  //MARK: - fetchSeriesQuery
  var filterSeriesQueryCallsCount = 0
  var filterSeriesQueryCalled: Bool {
    return filterSeriesQueryCallsCount > 0
  }
  
  var filterSeriesQueryReturnValue: AnyPublisher<Result<[Series], Error>, Never>!
  var filterSeriesQueryClosure: ((String) -> AnyPublisher<Result<[Series], Error>, Never>)?
  var filterSeriesQueryReceivedInvocations: [String] = []
  var filterSeriesQueryReceivedQuery: String?
  
  
  func filterSeries(query: String) -> AnyPublisher<Result<[Series], Error>, Never> {
    filterSeriesQueryCallsCount += 1
    filterSeriesQueryReceivedQuery = query
    filterSeriesQueryReceivedInvocations.append(query)
    return filterSeriesQueryClosure.map({ $0(query) }) ?? filterSeriesQueryReturnValue
    
  }
  
  
}
