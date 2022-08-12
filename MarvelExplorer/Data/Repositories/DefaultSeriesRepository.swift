//
//  DefaultMarvelSeriesRepository.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

// **Note**: DTOs structs are mapped into Domains here, and Repository protocols does not contain DTOs

import Foundation
import Combine
import MarvelExplorerDomain
import MarvelExplorerShared

typealias MarvelSeriesDTOResponse = MarvelResponse<SeriesDTO>

final public class DefaultMarvelSeriesRepository {

  let networkService: NetworkServiceType
  private(set) var seriesPaginator: MarvelPaginator<SeriesDTO>?

  init(networkService: NetworkServiceType) {
    self.networkService = networkService
  }

}

extension DefaultMarvelSeriesRepository: MarvelSeriesRepository {

  @MainActor
  public func fetchSeries() async throws -> [Series] {
    let seriesDTO =  try await networkService
      .load(Resource<MarvelSeriesDTOResponse>.getSeries(offset: self.seriesPaginator?.nextOffset,
                                                                                             limit: self.seriesPaginator?.limit))

    // Update current paginator
    self.seriesPaginator = seriesDTO.data

    let series = seriesDTO.data.results.map { $0.toDomain() }

    return series
  }
}
