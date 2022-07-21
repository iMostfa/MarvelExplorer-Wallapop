//
//  MarvelSeriesRepository.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine

/// Represents any data provider which will supply Series of marvel
public protocol MarvelSeriesRepository: AnyObject {

  func fetchSeries() async throws -> [Series]

}

extension MarvelSeriesRepository {
  func fetchSeries() async throws -> [Series] {
    fatalError("Make sure to override this, added for experiment only.")
  }
}
