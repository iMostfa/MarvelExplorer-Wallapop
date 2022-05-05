//
//  SeriesCellView.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import UIKit

struct SeriesCellViewComponents {
  let title: UILabel = {
    let title = UILabel.init()
    title.adjustsFontForContentSizeCategory = true
    title.translatesAutoresizingMaskIntoConstraints = false
    title.numberOfLines = 0
    title.lineBreakMode = .byWordWrapping
    title.textAlignment = .left
    title.font = .systemFont(ofSize: 13, weight: .semibold)

    return title
  }()

  let startYear: UILabel = {
    let subtitle = UILabel()
    subtitle.adjustsFontForContentSizeCategory = true
    subtitle.translatesAutoresizingMaskIntoConstraints = false
    subtitle.numberOfLines = 0
    subtitle.lineBreakMode = .byWordWrapping
    subtitle.textAlignment = .left
    subtitle.font = .systemFont(ofSize: 9, weight: .bold)
    subtitle.accessibilityIdentifier = AccessibilityIdentifiers.SeriesListCell.seriesStartYearLabel
    return subtitle
  }()

  let endYear: UILabel = {
    let subtitle = UILabel()
    subtitle.adjustsFontForContentSizeCategory = true
    subtitle.translatesAutoresizingMaskIntoConstraints = false
    subtitle.numberOfLines = 0
    subtitle.lineBreakMode = .byWordWrapping
    subtitle.textAlignment = .right
    subtitle.font = .systemFont(ofSize: 9, weight: .bold)
    subtitle.accessibilityIdentifier = AccessibilityIdentifiers.SeriesListCell.seriesEndYearLabel
    return subtitle
  }()

  var thumbnailView: UIImageView = {
    let imageView = UIImageView.init()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.accessibilityIdentifier = AccessibilityIdentifiers.SeriesListCell.seriesThumbnailImage

    return imageView
  }()
}
