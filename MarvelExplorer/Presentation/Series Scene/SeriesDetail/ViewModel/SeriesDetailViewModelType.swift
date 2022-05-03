//
//  SeriesDetailViewModelType.swift
//  MarvelExplorer
//
//  Created by Mostfa on 02/05/2022.
//

import Foundation
import Combine

protocol SeriesDetailViewModelType: AnyObject {
  func transform(input: SeriesDetailViewModelInput) -> SeriesDetailViewModelOutput
}

typealias SeriesDetailViewModelOutput = AnyPublisher<SeriesDetailState, Never>

enum SeriesDetailState {
  case success(SeriesDetailItemViewModel)
}


struct SeriesDetailViewModelInput {
  let onAppear: AnyPublisher<Void, Never>
}
