//
//  NetworkServiceType.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine
import RxSwift

public protocol NetworkServiceType: AnyObject {

  @discardableResult
  func load<Loadable>(_ resource: Resource<Loadable>) -> AnyPublisher<Loadable, Error>
  func load<Loadable>(_ resource: Resource<Loadable>) -> Observable<Loadable>
}

/// Network service errors.
public enum NetworkError: Error {
  case invalidRequest
  case invalidResponse
  case dataLoadingError(statusCode: Int, data: Data)
  case jsonDecodingError(error: Error)
}
