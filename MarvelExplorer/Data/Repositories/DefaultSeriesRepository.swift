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

  public func fetchSeries() -> AnyPublisher<Result<[Series], Error>, Never> {
    return networkService
      .load(Resource<MarvelSeriesDTOResponse>.getSeries(offset: self.seriesPaginator?.nextOffset,
                                                          limit: self.seriesPaginator?.limit))
      .subscribe(on: Scheduler.backgroundWorkScheduler)
      .receive(on: Scheduler.mainScheduler)
      .handleEvents(receiveOutput: { paginator in
        self.seriesPaginator = paginator.data
      })
      .map({ paginator -> Result<[Series], Error> in
        let e = paginator.data.results.map { $0.toDomain() }
        return .success(e)
      })
      .catch({ error -> AnyPublisher<Result<[Series], Error>, Never> in
        return .just(.failure(error))
      })
      .eraseToAnyPublisher()
  }

}
