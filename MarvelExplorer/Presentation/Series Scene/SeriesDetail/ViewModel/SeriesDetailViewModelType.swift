//
//  SeriesDetailViewModelType.swift
//  MarvelExplorer
//
//  Created by Mostfa on 02/05/2022.
//

import Foundation
import Combine

public protocol SeriesDetailViewModelType: AnyObject {
  func transform(input: SeriesDetailViewModelInput) -> SeriesDetailViewModelOutput
}

public typealias SeriesDetailViewModelOutput = AnyPublisher<SeriesDetailState, Never>

public enum SeriesDetailState {
  case success(SeriesDetailItemViewModel)
}

public struct SeriesDetailViewModelInput {
  let onAppear: AnyPublisher<Void, Never>
}
