//
//  SeriesListViewModelType.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine
import UIKit

public protocol SeriesListViewModelType: AnyObject {
  func transform(input: SeriesListViewModelInput) -> SeriesListViewModelOutput
}

public typealias SeriesListViewModelOutput = AnyPublisher<SeriesListState, Never>

public enum SeriesListState {
  case loading
  case success([SeriesListItemViewModel])
  case failure(Error)
}

extension SeriesListState: Equatable {
  static public func == (lhs: SeriesListState, rhs: SeriesListState) -> Bool {
    switch (lhs, rhs) {
    case (.loading, .loading): return true
    case (.success(let lhsSeries), .success(let rhsSeries)): return lhsSeries == rhsSeries
    case (.failure, .failure): return true
    default: return false
    }
  }
}

public struct SeriesListViewModelInput {
  let onAppear: AnyPublisher<Void, Never>
  let onSearch: AnyPublisher<String, Never>
  let onSeriesSelection: AnyPublisher<(UICollectionViewCell, Int), Never>
  let onPageRequest: AnyPublisher<Void, Never>
}
