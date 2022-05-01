//
//  SeriesListViewModel.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine

final class SeriesListViewModel: SeriesListViewModelType {
  
  private weak var navigator: SeriesListNavigator?
  private let useCase: FetchMarvelSeriesUseCaseType
  private let coverLoaderUseCase: LoadCoverUseCaseType
  private var cancellableBag = Set<AnyCancellable>()
  private var series: [SeriesListItemViewModel] = []

  
  init(useCase: FetchMarvelSeriesUseCaseType,
       coverLoaderUseCase: LoadCoverUseCaseType,
       navigator: SeriesListNavigator) {
    self.useCase = useCase
    self.coverLoaderUseCase = coverLoaderUseCase
    self.navigator = navigator
  }
  
  func transform(input: SeriesListViewModelInput) -> SeriesListViewModelOutput {
    cancellableBag.removeAll()
    
    //MARK: - on View Appear
    let series = input.onAppear
      .flatMapLatest { self.useCase.fetchSeries() }
      .map { result -> SeriesListState in
        switch result {
        case .success(let items):
          let seriesViewModels = items.map { SeriesListItemViewModel(series: $0,
                                                                     imageLoader: { series in
            return self.coverLoaderUseCase.loadSeriesCover(for: series)
            
          })}
          self.series = seriesViewModels
          return SeriesListState.success(seriesViewModels)
        case .failure(let error):
         return  SeriesListState.failure(error)
        }
      }.eraseToAnyPublisher()
    
    
    //MARK: - Handle Searching
    let filteredSeries = input.onSearch
      .flatMapLatest { self.filterSeries(query: $0) }
      .eraseToAnyPublisher()
      
    
    //MARK: - Handle page more Fetching
   let pageSeries = input.onPageRequest
      .print("FETCHING MORE PAGE!!")
      .flatMapLatest { self.useCase.fetchSeries() }
      .map { result -> SeriesListState in
        switch result {
        case .success(let items):
          //newSeriesViewModels  Will contain already fetched Series
          let newSeriesViewModels = items.map { SeriesListItemViewModel(series: $0,
                                                                        imageLoader: { series in
            return self.coverLoaderUseCase.loadSeriesCover(for: series)
            
          })}
          
          self.series = newSeriesViewModels
          return SeriesListState.success(self.series)
        case .failure(let error):
          return  SeriesListState.failure(error)
        }
      }
      .eraseToAnyPublisher()

    //MARK: - Loading Handling
    let loadingActions = Publishers.Merge(input.onPageRequest, input.onAppear)
      .print("Hello page Request")
      .map {_ in return SeriesListState.loading }
      .eraseToAnyPublisher()
    
    return Publishers
      .Merge4(pageSeries, loadingActions, series, filteredSeries)
      .removeDuplicates()
      .eraseToAnyPublisher()
  }
  
  /// Used to filter series based on a query.
  /// IMPORTANT: we are filtering data from the repository, since filtering might be a complex thing and its logic isn't view specific.
  /// - Parameter query: query of search
  /// - Returns: SeriesListState
  func filterSeries(query: String) -> AnyPublisher<SeriesListState,Never> {
    if query == "" { return .just(SeriesListState.success(series)) }
    return useCase.filterSeries(query: query)
      .map { result ->  SeriesListState in
        switch result {
        case .success(let items):
          return SeriesListState.success(items.map { SeriesListItemViewModel(series: $0,
                                                                                                     imageLoader: { series in
          return self.coverLoaderUseCase.loadSeriesCover(for: series)
          
        })}
)
        case .failure(let error): return SeriesListState.failure(error)
        }
      }.eraseToAnyPublisher()
        
  }
}
