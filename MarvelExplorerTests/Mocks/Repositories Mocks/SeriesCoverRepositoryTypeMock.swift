//
//  MarvelSeriesCoverRepositoryTypeMock.swift
//  MarvelExplorerTests
//
//  Created by Mostfa on 01/05/2022.
//

import Foundation
import XCTest
import Combine
@testable import MarvelExplorer

class MarvelSeriesCoverRepositoryMock: MarvelSeriesCoverRepository {

  var loadSeriesCoverCallsCount = 0
  var loadSeriesCoverWasCalled: Bool {
    return loadSeriesCoverCallsCount > 0
  }
  var loadSeriesCoverArguments: (String)?
  var loadSeriesCoverInvocations: [(String)] = []
  var loadSeriesCoverReturnValue: AnyPublisher<UIImage?, Never>!
  var loadSeriesCoverClosure: ((String) -> AnyPublisher<UIImage?, Never>)?

  func loadSeriesCover(with path: String) -> AnyPublisher<UIImage?, Never> {
    loadSeriesCoverCallsCount += 1
    loadSeriesCoverArguments = (path)
    loadSeriesCoverInvocations.append((path))
    return loadSeriesCoverClosure.map({ $0(path) }) ?? loadSeriesCoverReturnValue
  }

}
