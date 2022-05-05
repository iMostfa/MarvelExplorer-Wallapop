//
//  Publisher+flatMapLatest.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Combine

extension Publisher {

  /// Switches to latests publisher emitted by sourcePublisher
 public func flatMapLatest<T: Publisher>(_ transform: @escaping (Self.Output) -> T) -> Publishers.SwitchToLatest<T, Publishers.Map<Self, T>> where T.Failure == Self.Failure {
    map(transform).switchToLatest()
  }
}
