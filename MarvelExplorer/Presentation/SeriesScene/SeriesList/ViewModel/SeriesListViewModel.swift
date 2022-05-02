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
  private let fetchSeriesUseCase: FetchMarvelSeriesUseCaseType
  private let coverLoaderUseCase: LoadCoverUseCaseType
  private var cancellableBag = Set<AnyCancellable>()
  private var seriesViewModels: [SeriesListItemViewModel] = []

  
  init(fetchSeriesUseCase: FetchMarvelSeriesUseCaseType,
       coverLoaderUseCase: LoadCoverUseCaseType,
       navigator: SeriesListNavigator) {
    self.fetchSeriesUseCase = fetchSeriesUseCase
    self.coverLoaderUseCase = coverLoaderUseCase
    self.navigator = navigator
  }
  
  func transform(input: SeriesListViewModelInput) -> SeriesListViewModelOutput {
    cancellableBag.removeAll()
    
    //MARK: - on View Appear
    let series = input.onAppear
      .flatMapLatest { self.fetchSeriesUseCase.fetchSeries() }
      .map { [weak self] result -> SeriesListState in
        //for safety purposes, no use for unowned
        guard let self = self else { return .success([]) }

        switch result {
        case .success(let items):
          let seriesViewModels = self.viewModels(from: items)
          self.seriesViewModels += seriesViewModels
          return SeriesListState.success(seriesViewModels)
        case .failure(let error):
         return  SeriesListState.failure(error)
        }
      }.eraseToAnyPublisher()
    
    
    //MARK: - Handle Searching
    let filteredSeries = input.onSearch
      .flatMapLatest { self.filterSeries(in: self.seriesViewModels, query: $0) }
      .eraseToAnyPublisher()
      
    
    //MARK: - Handle page more Fetching
   let pageSeries = input.onPageRequest
      .flatMapLatest { self.fetchSeriesUseCase.fetchSeries() }
      .map { [weak self] result -> SeriesListState in
        //for safety purposes, no use for unowned
        guard let self = self else { return .success([]) }
        
        switch result {
        case .success(let items):
          //newSeriesViewModels  Will contain already fetched Series
          let newSeriesViewModels =  self.viewModels(from: items)
          
          self.seriesViewModels += newSeriesViewModels
          return SeriesListState.success(self.seriesViewModels)
        case .failure(let error):
          return  SeriesListState.failure(error)
        }
      }
      .eraseToAnyPublisher()

    //MARK: - Loading Handling
    let loadingActions = Publishers.Merge(input.onPageRequest, input.onAppear)
      .print("Should ShowLoading")
      .map {_ in return SeriesListState.loading }
      .eraseToAnyPublisher()
    
    return Publishers
      .Merge4(loadingActions,pageSeries, series, filteredSeries)
      .removeDuplicates()
      .eraseToAnyPublisher()
  }
  
  /// Used to filter series based on a query.
  /// IMPORTANT: we are filtering data from the repository, since filtering might be a complex thing and its logic isn't view specific.
  /// - Parameter query: query of search
  /// - Returns: SeriesListState
  func filterSeries(in viewModels: [SeriesListItemViewModel], query: String) -> AnyPublisher<SeriesListState,Never> {
    if query == "" { return .just(SeriesListState.success(viewModels)) }
    
    let filteredViewModels = viewModels.filter { viewModel in
      if viewModel.title.contains(query) { return  true }
      if "\(viewModel.endYear)".contains(query) { return  true }
      if "\(viewModel.startYear)".contains(query) { return  true }
      return false
    }
    
    return .just(.success(filteredViewModels)).eraseToAnyPublisher()
  }
  
func viewModels(from items: [Series]) -> [SeriesListItemViewModel] {
    return items.map { SeriesListItemViewModel(series: $0,
                                               imageLoader: { series in
      return self.coverLoaderUseCase.loadSeriesCover(for: series)
      
    })}
  }
  
}
