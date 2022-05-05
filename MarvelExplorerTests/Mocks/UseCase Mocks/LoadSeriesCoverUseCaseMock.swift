//
//  LoadSeriesCoverUseCase.swift
//  MarvelExplorerTests
//
//  Created by Mostfa on 01/05/2022.
//

import XCTest
import Combine
@testable import MarvelExplorer
@testable import MarvelExplorerDomain

class LoadSeriesCoverUseCaseMock: LoadCoverUseCaseType {

  var loadSeriesCoverForUsingClosure: ((Series) -> AnyPublisher<UIImage?, Never>)?
  var loadSeriesCoverForCallsCount = 0
  var loadSeriesCoverForNumberOfCalls: Bool {
    return loadSeriesCoverForCallsCount > 0
  }
  var loadSeriesCoverForUsingURL: Series?
  var loadSeriesCoverForInvocations: [Series] = []
  var loadSeriesCoverForReturnValue: AnyPublisher<UIImage?, Never>!

  func loadSeriesCover(for series: Series) -> AnyPublisher<UIImage?, Never> {
    loadSeriesCoverForCallsCount += 1
    loadSeriesCoverForUsingURL = series
    loadSeriesCoverForInvocations.append(series)
    return loadSeriesCoverForUsingClosure.map({ $0(series) }) ?? loadSeriesCoverForReturnValue
  }

}
