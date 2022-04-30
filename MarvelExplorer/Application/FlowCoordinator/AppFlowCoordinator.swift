//
//  AppFlowCoordinator.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import UIKit

typealias DependencyProvider = ApplicationFlowCoordinatorDependencyProvider

/// The main app flow coordinator,  responsible about coordinating view controllers and driving the flow.
class ApplicationFlowCoordinator: FlowCoordinator {
  
  private let window: UIWindow
  private var childCoordinators = [FlowCoordinator]()
  private let dependencyProvider: DependencyProvider
  
  init(window: UIWindow, dependencyProvider: DependencyProvider) {
    self.dependencyProvider = dependencyProvider
    self.window = window
  }
  
  /// Creates all needed dependencies and starts the flow
  func start() {
    let seriesListCoordinator = SeriesListFlowCoordinator.init(window: window,
                                                              dependencyProvider: dependencyProvider)
    childCoordinators = [seriesListCoordinator]
    seriesListCoordinator.start()
  }
  
}
