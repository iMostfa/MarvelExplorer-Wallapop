//
//  ApplicationFlowCoordinatorMock.swift
//  MarvelExplorerTests
//
//  Created by Mostfa on 01/05/2022.
//

import Foundation
import XCTest
@testable import MarvelExplorer
@testable import MarvelExplorerDomain
@testable import MarvelExplorerUI

class ApplicationFlowCoordinatorDependencyProviderMock: DependencyProvider {
  func seriesDetailsController(_ series: MarvelExplorerDomain.Series, delegate: MarvelExplorerUI.SeriesDetailViewControllerDelegate) -> UIViewController {
    return UIViewController(nibName: nil, bundle: nil)
  }

  func seriesCoverPreview(image: UIImage) -> UIViewController {
    return UIViewController(nibName: nil, bundle: nil)

  }

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
