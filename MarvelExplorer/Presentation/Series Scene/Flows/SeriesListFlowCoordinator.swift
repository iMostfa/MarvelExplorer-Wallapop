//
//  SeriesListFlowCoordinator.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import UIKit
import MarvelExplorerDomain
import MarvelExplorerUI

/// The `SeriesListFlowCoordinator` takes control over the form Series List screen.
class SeriesListFlowCoordinator: FlowCoordinator {

  fileprivate let window: UIWindow
  fileprivate var seriesNavigationController: UINavigationController?
  fileprivate let dependencyProvider: MarvelExplorerFlowCoordinatorDependencyProvider
  private let dimmingTransationDelegate = DimmingTransitioningDelegate()
  private let popTransitionDelegate = PopTransitioningDelegate()

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
    let vc = dependencyProvider.seriesDetailsController(series,
                                                        delegate: self)
    seriesNavigationController?.pushViewController(vc, animated: true)
  }
}

extension SeriesListFlowCoordinator: SeriesDetailViewControllerDelegate {
  public func showSeries(image: UIImage, frame: CGRect) {
    let vc = dependencyProvider.seriesCoverPreview(image: image)
    vc.modalPresentationStyle = .custom
    popTransitionDelegate.transition.originFrame = frame
    vc.transitioningDelegate = popTransitionDelegate
    seriesNavigationController?.present(vc, animated: true)
  }
}
