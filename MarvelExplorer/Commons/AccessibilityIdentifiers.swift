//
//  AccessibilityIdentifiers.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation

/// NameSpace used for Accessibility Support, and UI Testing
enum AccessibilityIdentifiers {

  public struct SeriesList {
      public static let searchFieldID = "\(SeriesList.self).searchFieldID"
      public static let mainViewID = "mainViewID"
      public static let cellID = "\(SeriesList.self).cellId"
      public static let collectionViewID = "\(SeriesList.self).collectionViewID"
  }

  public struct SeriesListCell {
    public static let seriesStartYearLabel = "\(SeriesListCell.self).seriesStartYearLabel"
    public static let seriesEndYearLabel = "\(SeriesListCell.self).seriesEndYearLabel"
    public static let seriesThumbnailImage = "\(SeriesListCell.self).thumbnailImage"
    public static let titleLabel = "\(SeriesListCell.self).titleLabel"

  }

  public struct SeriesDetail {
    public static let headerID = "\(SeriesDetail.self).HeaderView"
    public static let headerBlur = "\(SeriesDetail.self).HeaderBlur"
    public static let tableViewID = "\(SeriesDetail.self).tableViewID"

  }

}
