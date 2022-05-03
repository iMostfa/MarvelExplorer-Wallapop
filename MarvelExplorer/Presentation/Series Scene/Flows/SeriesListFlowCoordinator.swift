//
//  SeriesListFlowCoordinator.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import UIKit



/// The `SeriesListFlowCoordinator` takes control over the form Series List screen.
class SeriesListFlowCoordinator: FlowCoordinator {

  fileprivate let window: UIWindow
  fileprivate var seriesNavigationController: UINavigationController?
  fileprivate let dependencyProvider: MarvelExplorerFlowCoordinatorDependencyProvider
  
  init(window: UIWindow, dependencyProvider: MarvelExplorerFlowCoordinatorDependencyProvider) {
    self.window = window
    self.dependencyProvider = dependencyProvider
  }
  
  func start() {
    let seriesNavigationController = dependencyProvider.seriesListNavigationController(navigator: self)
    window.rootViewController = seriesNavigationController
    self.seriesNavigationController = seriesNavigationController
  }
}


extension SeriesListFlowCoordinator: SeriesListNavigator {
  func showDetails(for series: Series) {
    let vc = dependencyProvider.seriesDetailsController(series)
    seriesNavigationController?.pushViewController(vc, animated: true)
  }
}
