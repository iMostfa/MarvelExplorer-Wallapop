//
//  Publisher+ asyncMap.swift
//  MarvelExplorer
//
//  Created by Mostfa on 20/07/2022.
//

import Combine

extension Publisher {

  func asyncFlatMap<T>(
    _ transform: @escaping (Output) async throws -> T
  ) -> Publishers.FlatMap<Future<T, Error>, Self> {

    return asyncMap(transform)
  }
  /// https://www.swiftbysundell.com/articles/calling-async-functions-within-a-combine-pipeline/
  /// - Parameter transform:
  /// - Returns:
  public func asyncMap<T>(
    _ transform: @escaping (Output) async throws -> T
  ) -> Publishers.FlatMap<Future<T, Self.Failure>, Self> {

    flatMap { value in
      Future { promise in
        Task {
          // TODO: - We should try to see how can we make flatMapLatest Behaviours
          do {
            let output = try await transform(value)
            promise(.success(output))
          } catch {
            promise(.failure(error as! Self.Failure))
          }
        }
      }
    }
  }
}
