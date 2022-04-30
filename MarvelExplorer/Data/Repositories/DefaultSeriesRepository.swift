//
//  DefaultSeriesRepository.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

// **Note**: DTOs structs are mapped into Domains here, and Repository protocols does not contain DTOs

import Foundation
import Combine
final class DefaultSeriesRepository {
  
  private let session: URLSession
  
  init(session: URLSession) { self.session = session }
  
}

extension DefaultSeriesRepository: MarvelSeriesRepository {
  
  func fetchSeries() -> AnyPublisher<[Series], Never> {
    return .empty()
  }

}
