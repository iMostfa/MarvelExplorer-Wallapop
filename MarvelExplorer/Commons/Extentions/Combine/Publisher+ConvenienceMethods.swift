//
//  Publisher+ConvenienceMethods.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Combine

extension Publisher {

  static func empty() -> AnyPublisher<Output, Failure> {
    return Empty().eraseToAnyPublisher()
  }

  static func just(_ output: Output) -> AnyPublisher<Output, Failure> {
    return Just(output)
    // TODO: - Silence This error
      .catch { _ in AnyPublisher<Output, Failure>.empty() }
      .eraseToAnyPublisher()
  }

  static func fail(_ error: Failure) -> AnyPublisher<Output, Failure> {
    return Fail(error: error).eraseToAnyPublisher()
  }
}
