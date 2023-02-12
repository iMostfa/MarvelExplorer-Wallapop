//
//  SeriesListNavigatorMock.swift
//  MarvelExplorerTests
//
//  Created by Mostfa on 01/05/2022.
//

import Foundation
import XCTest
import Combine
@testable import MarvelExplorer
@testable import MarvelExplorerDomain
@testable import MarvelExplorerUI

class SeriesListNavigatorMock: SeriesListNavigator {

  // MARK: - showDetails

  var showDetailsForSeriesCallsCount = 0
  var showDetailsForSeriesCalled: Bool {
    return showDetailsForSeriesCallsCount > 0
  }

  var showDetailsForClosure: ((Series) -> Void)?
  var showDetailsForReceivedSeriesId: Series?
  var showDetailsForReceivedInvocations: [Series] = []

  func showDetails(for series: Series, fromFrame: CGRect) {
    showDetailsForSeriesCallsCount += 1
    showDetailsForReceivedSeriesId = series
    showDetailsForReceivedInvocations.append(series)
    showDetailsForClosure?(series)
  }

}
