//
//  ApplicationFlowCoordinatorTests.swift
//  MarvelExplorerTests
//
//  Created by Mostfa on 01/05/2022.
//

import Foundation
import XCTest
@testable import MarvelExplorer


class ApplicationFlowCoordinatorTests: XCTestCase {
  
  private lazy var flowCoordinator = ApplicationFlowCoordinator(window: window, dependencyProvider: dependencyProvider)
  private let window =  UIWindow()
  private let dependencyProvider = ApplicationFlowCoordinatorDependencyProviderMock()
  
  /// Test that application flow is started correctly
  func test_startsApplicationsFlow() {
    // given
    let rootViewController = UINavigationController()
    dependencyProvider.seriesListNavigationControllerReturnValue = rootViewController
    
    // when
    flowCoordinator.start()
    
    // then
    XCTAssertEqual(window.rootViewController, rootViewController)
  }
}
