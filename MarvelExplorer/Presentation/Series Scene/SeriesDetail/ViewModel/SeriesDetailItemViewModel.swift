//
//  SeriesDetailItemViewModel.swift
//  MarvelExplorer
//
//  Created by Mostfa on 02/05/2022.
//

import Foundation
import Combine
import UIKit
struct SeriesDetailItemViewModel: Equatable, Hashable, Identifiable {
  let id: Int
  let title: String
  let seriesDetails: [SeriesDetail]
  let cover: AnyPublisher<UIImage?, Never>
  
  
  enum SeriesDetail {
    case creators([Creator])
    case startYear(Int)
    case endYear(Int)
    case description(String)
  }
  
}

extension SeriesDetailItemViewModel {
  static func == (lhs: SeriesDetailItemViewModel, rhs: SeriesDetailItemViewModel) -> Bool {
    lhs.id == rhs.id
  }
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
extension SeriesDetailItemViewModel {
  init(series: Series,
       imageLoader: (Series) -> AnyPublisher<UIImage?, Never>) {
    let creators = series.creators
    
    self.id = series.id
    self.title = series.name
    self.cover = imageLoader(series)
    
    let seriesDetails: [SeriesDetailItemViewModel.SeriesDetail] = [
      .description(series.description ?? "No Description for \(series.name)"),
      .endYear(series.endYear),
      .startYear(series.startYear),
      .creators(creators)
    ]
    
    self.seriesDetails = seriesDetails
  }
}
