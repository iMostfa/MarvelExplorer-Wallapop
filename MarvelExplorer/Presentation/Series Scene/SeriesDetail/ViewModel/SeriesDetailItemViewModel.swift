//
//  SeriesDetailItemViewModel.swift
//  MarvelExplorer
//
//  Created by Mostfa on 02/05/2022.
//

import Foundation
import Combine
import UIKit
import MarvelExplorerDomain

public struct SeriesDetailItemViewModel: Equatable, Hashable, Identifiable {

  private var series: Series

  public var id: Int {
     series.id
  }

  var title: String {
    return series.name
  }
  let seriesDetails: [SeriesDetail]

  var cover: UIImage? {
    get async throws {
       try await imageLoader(series)
    }
  }

  var imageLoader: ((Series) async throws -> UIImage?)

  init(series: Series,
       imageLoader: @escaping ((Series) async throws -> UIImage?) ) {
    let creators = series.creators
    self.series = series
    self.imageLoader = imageLoader

    let seriesDetails: [SeriesDetailItemViewModel.SeriesDetail] = [
      .description(series.description ?? "No Description for \(series.name)"),
      .endYear(series.endYear),
      .startYear(series.startYear),
      .creators(creators)
    ]

    self.seriesDetails = seriesDetails
  }

  enum SeriesDetail {
    case creators([Creator])
    case startYear(Int)
    case endYear(Int)
    case description(String)
  }

}

extension SeriesDetailItemViewModel {
  public static func == (lhs: SeriesDetailItemViewModel, rhs: SeriesDetailItemViewModel) -> Bool {
    lhs.id == rhs.id
  }
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
