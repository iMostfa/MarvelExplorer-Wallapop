//
//  SeriesListItemViewModel.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine
import UIKit
import MarvelExplorerDomain

public struct SeriesListItemViewModel: Equatable, Hashable, Identifiable {

  public var id: Int {
    return series.id
  }

  private let series: Series

  var title: String {
    series.name
  }

  let description: String?
  let endYear, startYear: String

  var cover: UIImage? {
    get async throws {
      try await imageLoader(series)
    }
  }
  var imageLoader: ((Series) async throws -> UIImage?)

}

extension SeriesListItemViewModel {
  public static func == (lhs: SeriesListItemViewModel, rhs: SeriesListItemViewModel) -> Bool {
    lhs.id == rhs.id
  }
  // TODO: should implement a safer one to avoid collision, maybe using id from response
  public func hash(into hasher: inout Hasher) {
    hasher.combine(title)
  }
}
extension SeriesListItemViewModel {
  init(series: Series,
       imageLoader: @escaping ((Series) async throws -> UIImage?)) {
    self.series = series
    self.description = series.description
    self.startYear =  "SEREIS_SINCE".localized(params: "\(series.startYear)")
    self.endYear = series.endYear != 2099 ? "SEREIS_UNTIL".localized(params: "\(series.endYear)"):
    "SERIES_PRESENT".localized()
    self.imageLoader = imageLoader
  }
}
