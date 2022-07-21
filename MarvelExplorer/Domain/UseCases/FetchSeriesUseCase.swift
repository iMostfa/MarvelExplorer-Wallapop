//
//  FetchSeriesUseCase.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine

public protocol FetchMarvelSeriesUseCaseType: AnyObject {
  func fetchSeriesAsync() async throws -> [Series]

  // If we filtering using Repository(API) we would have this:
  //  func filterSeries(query: String) -> AnyPublisher<Result<[Series], Error>, Never> /* Le
}

final public class DefaultFetchMarvelSeriesUseCase: FetchMarvelSeriesUseCaseType {

  private let seriesRepository: MarvelSeriesRepository

  public init(seriesRepository: MarvelSeriesRepository) {
    self.seriesRepository = seriesRepository
  }

  public func fetchSeriesAsync() async throws -> [Series] {
    return try await seriesRepository.fetchSeries()
  }
}
