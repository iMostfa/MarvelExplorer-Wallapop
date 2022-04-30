//
//  DefaultSeriesRepository.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

// **Note**: DTOs structs are mapped into Domains here, and Repository protocols does not contain DTOs

import Foundation
import Combine
final class DefaultSeriesRepository {
  
  private let networkService: NetworkServiceType
  
  
  init(networkService: NetworkServiceType) { self.networkService = networkService }
  
}

extension DefaultSeriesRepository: MarvelSeriesRepository {
  
  func fetchSeries() -> AnyPublisher<[Series], Error> {
    return networkService
      .load(Resource<MarvelResponse<SeriesDTO>>.getSeries())
      .map(\.data)
      .map { $0.results.map { $0.toDomain() } }
      .eraseToAnyPublisher()
  }

}
