//
//  SeriesListDataSource.swift
//  MarvelExplorer
//
//  Created by Mostfa on 03/05/2022.
//

import Foundation
import UIKit
import Combine

typealias SeriesSnapshot = NSDiffableDataSourceSnapshot<SeriesDataSourceSection,SeriesListItemViewModel>

enum SeriesDataSourceSection {
  case main
}


/// SeriesDataSource is a subclass of UICollectionViewDiffableDataSource<SeriesDataSourceSection, SeriesListItemViewModel>, incase some Data sources functions needed to be implemented.
/// and as a type-alias around the generic.
final class SeriesListCollectionViewDataSource: UICollectionViewDiffableDataSource<SeriesDataSourceSection, SeriesListItemViewModel> { }
