//
//  SeriesListViewModelType.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine

protocol SeriesListViewModelType {
  func transform(input: SeriesListViewModelInput) -> SeriesListViewModelOutput
}

typealias SeriesListViewModelOutput = AnyPublisher<SeriesListState, Never>

enum SeriesListState {
  case loading
  case success([SeriesListItemViewModel])
  case failure(Error)
}

extension SeriesListState: Equatable {
  static func == (lhs: SeriesListState, rhs: SeriesListState) -> Bool {
    switch (lhs, rhs) {
    case (.loading, .loading): return true
    case (.success(let lhsSeries), .success(let rhsSeries)): return lhsSeries == rhsSeries
    case (.failure, .failure): return true
    default: return false
    }
  }
}

struct SeriesListViewModelInput {
  let onAppear: AnyPublisher<Void, Never>
  let onSearch: AnyPublisher<String, Never>
  let onSeriesSelection: AnyPublisher<Int, Never>
  let onPageRequest: AnyPublisher<Void, Never>
}
