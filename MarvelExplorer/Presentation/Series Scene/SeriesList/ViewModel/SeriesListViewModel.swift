//
//  SeriesListViewModel.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine
import MarvelExplorerDomain

final public class SeriesListViewModel: SeriesListViewModelType {

  private weak var navigator: SeriesListNavigator?
  private let fetchSeriesUseCase: FetchMarvelSeriesUseCaseType
  private let coverLoaderUseCase: LoadCoverUseCaseType
  private var cancellableBag = Set<AnyCancellable>()

  private var series: [Series] = []

  public init(fetchSeriesUseCase: FetchMarvelSeriesUseCaseType,
       coverLoaderUseCase: LoadCoverUseCaseType,
       navigator: SeriesListNavigator) {
    self.fetchSeriesUseCase = fetchSeriesUseCase
    self.coverLoaderUseCase = coverLoaderUseCase
    self.navigator = navigator
  }

  public func transform(input: SeriesListViewModelInput) -> SeriesListViewModelOutput {
    cancellableBag.removeAll()

    // MARK: - on View Appear
    let series = input.onAppear
      .flatMapLatest { self.fetchSeriesUseCase.fetchSeries() }
      .map { [weak self] result -> SeriesListState in
        // for safety purposes, no use for unowned
        guard let self = self else { return .success([]) }

        switch result {
        case .success(let items):
          self.series += items
          let seriesViewModels = self.viewModels(from: self.series)
          return SeriesListState.success(seriesViewModels)
        case .failure(let error):
         return  SeriesListState.failure(error)
        }
      }.eraseToAnyPublisher()

    // MARK: - Handle Searching
    let filteredSeries = input.onSearch
      .flatMapLatest { self.filterSeries(in: self.series, query: $0) }
      .eraseToAnyPublisher()

    // MARK: - On Item Selection Handling
    input.onSeriesSelection.sink { [weak self] (cell, index) in
      guard let self = self else { return }
      guard  index <= self.series.count else { return assertionFailure("Wrong index was tapped, would happen only if viewModels array were cleared.")}

      let selectedSeries = self.series[index]
      guard let cellSuperView = cell.superview else { return }
      let rect = cellSuperView.convert(cell.frame, to: nil)

      self.navigator?.showDetails(for: selectedSeries, fromFrame: rect)
    }.store(in: &cancellableBag)

    // MARK: - Handle page more Fetching
   let pageSeries = input.onPageRequest
      .flatMapLatest { self.fetchSeriesUseCase.fetchSeries() }
      .map { [weak self] result -> SeriesListState in
        // for safety purposes, no use for unowned
        guard let self = self else { return .success([]) }

        switch result {
        case .success(let items):
          // newSeriesViewModels  Will contain already fetched Series
          self.series += items
          let newSeriesViewModels =  self.viewModels(from: self.series)

          return SeriesListState.success(newSeriesViewModels)
        case .failure(let error):
          return  SeriesListState.failure(error)
        }
      }
      .eraseToAnyPublisher()

    // MARK: - Loading Handling
    let loadingActions = Publishers.Merge(input.onPageRequest, input.onAppear)
      .print("Should ShowLoading")
      .map { _ in return SeriesListState.loading }
      .eraseToAnyPublisher()

    return Publishers
      .Merge4(loadingActions, pageSeries, series, filteredSeries)
      .removeDuplicates()
      .eraseToAnyPublisher()
  }

  /// Used to filter series based on a query.
  /// IMPORTANT: we are filtering data from the viewModel, removed it from repository until it's implemented it using the API.
  /// - Parameter query: query of search
  /// - Returns: SeriesListState
  func filterSeries(in models: [Series], query: String) -> AnyPublisher<SeriesListState, Never> {
    if query == "" { return .just(SeriesListState.success(viewModels(from: models))) }

    let filteredModels = models.filter { model in
      if model.name.contains(query) ||
        "\(model.endYear)".contains(query) ||
       "\(model.startYear)".contains(query) { return true }
      return false
    }

    let filteredViewModels = viewModels(from: filteredModels)

    return .just(.success(filteredViewModels)).eraseToAnyPublisher()
  }

func viewModels(from items: [Series]) -> [SeriesListItemViewModel] {
    return items.map { SeriesListItemViewModel(series: $0,
                                               imageLoader: { series in
      return self.coverLoaderUseCase.loadSeriesCover(for: series)

    })}
  }

}
