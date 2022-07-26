//
//  MarvelSeriesRepository.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine
import RxSwift

/// Represents any data provider which will supply Series of marvel
public protocol MarvelSeriesRepository: AnyObject {

  func fetchSeries() -> AnyPublisher<Result<[Series], Error>, Never>
  func fetchSeries() -> Observable<[Series]>
}
