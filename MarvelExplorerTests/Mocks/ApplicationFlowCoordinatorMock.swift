//
//  ApplicationFlowCoordinatorMock.swift
//  MarvelExplorerTests
//
//  Created by Mostfa on 01/05/2022.
//

import Foundation
import XCTest
@testable import MarvelExplorer

class ApplicationFlowCoordinatorDependencyProviderMock: ApplicationFlowCoordinatorDependencyProvider {

  var seriesListNavigationControllerReturnValue: UINavigationController?
  var seriesDetailsControllerReturnValue: UIViewController?

  func seriesDetailsController(_ series: Series) -> UIViewController {
    return seriesListNavigationControllerReturnValue!
  }

  func seriesListNavigationController(navigator: SeriesListNavigator) -> UINavigationController {
    return seriesListNavigationControllerReturnValue!
  }

  func seriesDetailsController(_ seriesID: Int) -> UIViewController {
    return seriesDetailsControllerReturnValue!
  }
}
