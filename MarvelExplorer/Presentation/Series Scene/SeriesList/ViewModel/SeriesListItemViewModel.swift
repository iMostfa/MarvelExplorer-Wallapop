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
  public let id: Int
  let title: String
  let description: String?
  let endYear, startYear: String
  let cover: AnyPublisher<UIImage?, Never>

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
       imageLoader: (Series) -> AnyPublisher<UIImage?, Never>) {
    self.id = series.id
    self.title = series.name
    self.description = series.description
    self.startYear =  "SEREIS_SINCE".localized(params: "\(series.startYear)")
    self.endYear = series.endYear != 2099 ? "SEREIS_UNTIL".localized(params: "\(series.endYear)"):
    "SERIES_PRESENT".localized()
    self.cover = imageLoader(series)
  }
}
