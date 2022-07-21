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
  func load<Loadable>(_ resource: Resource<Loadable>) async throws -> Loadable where Loadable: Decodable, Loadable: Encodable {
    guard let request = resource.request else {
      throw "Can't get the request"
    }

    let (data, response) = try await session.data(for: request)

    guard let response = response as? HTTPURLResponse else { throw NetworkError.invalidResponse }

    guard 200..<300 ~= response.statusCode else { throw NetworkError.dataLoadingError(statusCode: response.statusCode,
                                                                                      data: data)
    }

    return try jsonDecoder.decode(Loadable.self, from: data)

  }

  @discardableResult
  func load<Loadable>(_ resource: Resource<Loadable>) -> AnyPublisher<Loadable, Error> {
    guard let request = resource.request else {
      return .fail(NetworkError.invalidRequest)
    }
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
      .decode(type: Loadable.self, decoder: jsonDecoder)
      .eraseToAnyPublisher()
  }

}
