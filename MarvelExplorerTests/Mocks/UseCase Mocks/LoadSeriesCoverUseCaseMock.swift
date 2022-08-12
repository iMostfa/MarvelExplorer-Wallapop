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
  func loadSeriesCover(for series: Series) async throws -> UIImage? {
    loadSeriesCoverForCallsCount += 1
    loadSeriesCoverForUsingURL = series
    loadSeriesCoverForInvocations.append(series)
    return loadSeriesCoverForUsingClosure.map({ $0(series) }) ?? loadSeriesCoverForReturnValue

  }

  var loadSeriesCoverForUsingClosure: ((Series) -> UIImage?)?
  var loadSeriesCoverForCallsCount = 0
  var loadSeriesCoverForNumberOfCalls: Bool {
    return loadSeriesCoverForCallsCount > 0
  }
  var loadSeriesCoverForUsingURL: Series?
  var loadSeriesCoverForInvocations: [Series] = []
  var loadSeriesCoverForReturnValue: UIImage!

}
