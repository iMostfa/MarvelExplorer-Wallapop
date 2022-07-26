//
//  FetchSeriesUseCase.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine
import RxCombine
public protocol FetchMarvelSeriesUseCaseType: AnyObject {
  func fetchSeries() -> AnyPublisher<Result<[Series], Error>, Never>

  // If we filtering using Repository(API) we would have this:
  //  func filterSeries(query: String) -> AnyPublisher<Result<[Series], Error>, Never> /* Le
}

final public class DefaultFetchMarvelSeriesUseCase: FetchMarvelSeriesUseCaseType {

  private let seriesRepository: MarvelSeriesRepository

  public init(seriesRepository: MarvelSeriesRepository) {
    self.seriesRepository = seriesRepository
  }

  public func fetchSeries() -> AnyPublisher<Result<[Series], Error>, Never> {
    let observable = seriesRepository
      .fetchSeries()
      .asObservable()
      .map({ series in
        return Result<[Series], Error>.init {
          return series
        }
      })
      .publisher
      .assertNoFailure()
      .eraseToAnyPublisher()

    return observable
  }

}
