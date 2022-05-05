//
//  SeriesDetailViewModel.swift
//  MarvelExplorer
//
//  Created by Mostfa on 02/05/2022.
//

import Foundation
import Combine

final class SeriesDetailViewModel: SeriesDetailViewModelType {

  private let coverLoaderUseCase: LoadCoverUseCaseType
  private var cancellableBag = Set<AnyCancellable>()
  let series: Series

  init(series: Series, coverLoaderUseCase: LoadCoverUseCaseType) {
    self.series = series
    self.coverLoaderUseCase = coverLoaderUseCase
  }

  func transform(input: SeriesDetailViewModelInput) -> SeriesDetailViewModelOutput {

    let model =  input.onAppear
      .flatMapLatest { () -> AnyPublisher<SeriesDetailState, Never> in

        let viewModel = SeriesDetailItemViewModel.init(series: self.series,
                                                       imageLoader: self.coverLoaderUseCase.loadSeriesCover(for:))

        return .just(.success(viewModel))
      }

    return model.eraseToAnyPublisher()
  }

}
