//
//  NetworkServiceMock.swift
//  MarvelExplorerTests
//
//  Created by Mostfa on 01/05/2022.
//

import Foundation
import XCTest
import Combine
@testable import MarvelExplorer
@testable import MarvelExplorerData

class NetworkServiceTypeMock: NetworkServiceType {

  func load<Loadable>(_ resource: Resource<Loadable>) async throws -> Loadable where Loadable: Decodable, Loadable: Encodable {

    if let response = responses[resource.url.path] as? Loadable {
    return response
    } else if let error = responses[resource.url.path] as? NetworkError {
      throw error
    } else {
      throw NetworkError.invalidRequest
    }
  }

  var loadCallsCount = 0
  var loadCalled: Bool {
    return loadCallsCount > 0
  }
  var responses = [String: Any]()

  func load<T>(_ resource: Resource<T>) -> AnyPublisher<T, Error> {
    if let response = responses[resource.url.path] as? T {
      return .just(response)
    } else if let error = responses[resource.url.path] as? NetworkError {
      return .fail(error)
    } else {
      return .fail(NetworkError.invalidRequest)
    }
  }
}
