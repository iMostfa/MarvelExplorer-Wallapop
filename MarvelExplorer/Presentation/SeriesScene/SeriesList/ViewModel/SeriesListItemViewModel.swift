//
//  SeriesListItemViewModel.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine
import UIKit

struct SeriesListItemViewModel: Equatable, Hashable, Identifiable {
  let id: Int
  let title: String
  let description: String?
  let endYear,startYear: String
  let cover: AnyPublisher<UIImage?, Never>

}

extension SeriesListItemViewModel {
  static func == (lhs: SeriesListItemViewModel, rhs: SeriesListItemViewModel) -> Bool {
    lhs.id == rhs.id
  }
  //TODO: should implement a safer one to avoid collision, maybe using id from response
  func hash(into hasher: inout Hasher) {
    hasher.combine(title)
  }
}
extension SeriesListItemViewModel {
  init(series: Series,
       imageLoader: (Series) -> AnyPublisher<UIImage?, Never>) {
    self.id = series.id
    self.title = series.name
    self.description = series.description
    self.startYear = "Since:\(series.startYear)"
    self.endYear = series.endYear != 2099 ? "Until:\(series.endYear)": "Present"
    self.cover = imageLoader(series)
  }
}
