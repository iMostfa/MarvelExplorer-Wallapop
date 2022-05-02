//
//  FetchSeriesUseCase.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine


protocol FetchMarvelSeriesUseCaseType {
  func fetchSeries() -> AnyPublisher<Result<[Series], Error>, Never>
//  func filterSeries(query: String) -> AnyPublisher<Result<[Series], Error>, Never>
}

final class DefaultFetchMarvelSeriesUseCase: FetchMarvelSeriesUseCaseType {
  
  private let seriesRepository: MarvelSeriesRepository
  
  init(seriesRepository: MarvelSeriesRepository) {
    self.seriesRepository = seriesRepository
  }
  
//  func filterSeries(query: String) -> AnyPublisher<Result<[Series], Error>, Never> {
//    return seriesRepository.filterSeries(query: query)
//  }
  
  func fetchSeries() -> AnyPublisher<Result<[Series], Error>, Never> {
    return seriesRepository.fetchSeries()
  }
  
}
