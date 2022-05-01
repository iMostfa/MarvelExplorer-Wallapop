//
//  MarvelSeriesRepository.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine
/// Represents any data provider which will supply Series of marvel
protocol MarvelSeriesRepository {
  
  func fetchSeries() -> AnyPublisher<Result<[Series], Error>, Never>
  func filterSeries(query: String) -> AnyPublisher<Result<[Series], Error>, Never>


}
