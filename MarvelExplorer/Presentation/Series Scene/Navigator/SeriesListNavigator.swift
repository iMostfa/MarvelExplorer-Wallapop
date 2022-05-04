//
//  SeriesListNavigator.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation

protocol SeriesListNavigator: AnyObject {
  /// Presented a Series details view..
  func showDetails(for series: Series)
}