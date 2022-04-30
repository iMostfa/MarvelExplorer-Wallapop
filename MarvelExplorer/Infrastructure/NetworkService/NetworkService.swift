//
//  NetworkService.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine

final class NetworkService: NetworkServiceType {
  private let session: URLSession
  private let jsonDecoder: JSONDecoder
  init(session: URLSession = URLSession(configuration: URLSessionConfiguration.ephemeral), jsonDecoder: JSONDecoder = JSONDecoder()) {
    self.session = session
    self.jsonDecoder = jsonDecoder
  }

  @discardableResult
  func load<Loadable>(_ resource: Resource<Loadable>?) -> AnyPublisher<Loadable, Error> {
    guard var request = resource?.request else {
      return .fail(NetworkError.invalidRequest)
    }
    // - Authorisation shouldn't placed here
    request.addValue("Bearer \(MarvelConstants.apiKey)", forHTTPHeaderField: "Authorization")
    return session.dataTaskPublisher(for: request)
      .mapError { _ in NetworkError.invalidRequest }
      .flatMap { data, response -> AnyPublisher<Data, Error> in
        guard let response = response as? HTTPURLResponse else {
          return .fail(NetworkError.invalidResponse)
        }

        guard 200..<300 ~= response.statusCode else {
          return .fail(NetworkError.dataLoadingError(statusCode: response.statusCode, data: data))
        }
        return .just(data)
      }
      .decode(type: Loadable.self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }

}
