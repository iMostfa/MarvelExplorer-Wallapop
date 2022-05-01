//
//  DefaultMarvelSeriesRepository.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

// **Note**: DTOs structs are mapped into Domains here, and Repository protocols does not contain DTOs

import Foundation
import Combine

typealias MarvelSeriesDTOResponse = MarvelResponse<SeriesDTO>

final class DefaultMarvelSeriesRepository {
  
  let networkService: NetworkServiceType
  private(set) var seriesPaginator: MarvelPaginator<SeriesDTO>?
  private var series: [SeriesDTO] = []

  
  
  init(networkService: NetworkServiceType) {
    self.networkService = networkService
  }
  
}

extension DefaultMarvelSeriesRepository: MarvelSeriesRepository {

  func filterSeries(query: String) -> AnyPublisher<Result<[Series], Error>, Never> {
    
     let filteredSeries = series.filter { seriesDTO in
       
       if seriesDTO.title.contains(query) { return  true }
       if "\(seriesDTO.endYear)".contains(query) { return  true }
       if "\(seriesDTO.startYear)".contains(query) { return  true }
       
      return false
     }.map { $0.toDomain() }
    
    return .just(.success(filteredSeries))
  }
  
  func fetchSeries() -> AnyPublisher<Result<[Series], Error>, Never> {
    return networkService
      .load(Resource<MarvelSeriesDTOResponse>.getSeries(offset: self.seriesPaginator?.nextOffset,
                                                          limit: self.seriesPaginator?.limit))
      .subscribe(on: Scheduler.backgroundWorkScheduler)
      .receive(on: Scheduler.mainScheduler)
      .handleEvents(receiveOutput: { paginator in
        self.seriesPaginator = paginator.data
        //Note: since we are not editing paginator.data, COW(copy on write) will save us, and no duplication should happen :)
        self.series = self.series + paginator.data.results
      })
      .map { _ in self.series }
      .map({ elements -> Result<[Series],Error> in
        let e = elements.map { $0.toDomain() }
        return .success(e)
      })
      .catch({ error -> AnyPublisher<Result<[Series],Error>,Never> in
        return .just(.failure(error))
      })
      .eraseToAnyPublisher()
  }

}
