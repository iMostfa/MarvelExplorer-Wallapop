//
//  ApplicationFlowCoordinatorDependencyProvider.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import UIKit
import MarvelExplorerDomain
import MarvelExplorerUI

/// The `ApplicationFlowCoordinatorDependencyProvider` protocol defines methods to satisfy external dependencies of the ApplicationFlowCoordinator
protocol ApplicationFlowCoordinatorDependencyProvider: MarvelExplorerFlowCoordinatorDependencyProvider {}

protocol MarvelExplorerFlowCoordinatorDependencyProvider: AnyObject {
  /// Creates a controller list all series.
  func seriesListNavigationController(navigator: SeriesListNavigator) -> UINavigationController

  // Creates UIViewController to show the details of a series.
  func seriesDetailsController(_ series: Series, delegate: SeriesDetailViewControllerDelegate) -> UIViewController

  // Creates UIViewController to show the details of a series.
  func seriesCoverPreview(image: UIImage) -> UIViewController
}
