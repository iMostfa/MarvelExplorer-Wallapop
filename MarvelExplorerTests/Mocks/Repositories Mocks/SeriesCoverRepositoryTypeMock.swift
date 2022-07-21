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
@testable import MarvelExplorerDomain

class MarvelSeriesCoverRepositoryMock: MarvelSeriesCoverRepository {

  func loadSeriesCover(with path: String) async throws -> UIImage? {
    loadSeriesCoverCallsCount += 1
    loadSeriesCoverArguments = (path)
    loadSeriesCoverInvocations.append((path))
    return loadSeriesCoverClosure.map({ $0(path) }) ?? loadSeriesCoverReturnValue

  }

  var loadSeriesCoverCallsCount = 0
  var loadSeriesCoverWasCalled: Bool {
    return loadSeriesCoverCallsCount > 0
  }
  var loadSeriesCoverArguments: (String)?
  var loadSeriesCoverInvocations: [(String)] = []
  var loadSeriesCoverReturnValue: UIImage!
  var loadSeriesCoverClosure: ((String) -> UIImage?)?

}
