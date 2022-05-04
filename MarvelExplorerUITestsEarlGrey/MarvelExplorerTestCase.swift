//
//  MarvelExplorerTestCase.swift
//  MarvelExplorerUITests
//
//  Created by Mostfa on 01/05/2022.
//

import Foundation
@testable import MarvelExplorer

import XCTest

class MarvelExplorerTestCase: XCTestCase {
  
  //  MARK: - Services
  lazy var networkService = NetworkServiceTypeMock()
  
  lazy var imageLoader: ImageLoaderServiceType = {
    let mock = ImageLoaderServiceTypeMock()
    mock.loadImageUsingClosure = { _ in
      let image = UIImage(named: "defaultCover.jpg", in: Bundle(for: EarlGreyImpl.self), compatibleWith: nil)
      return .just(image)
    }
    return mock
  }()
  
  //  MARK: - Repositories
  lazy var seriesCoversRepository = MarvelSeriesCoverRepositoryMock.init()
  lazy var seriesRepository = MarvelSeriesRepositoryMock.init()
  
  
  //  MARK: - Factory
  lazy var factory = ApplicationComponentsFactory(servicesProvider: .init(network: networkService,
                                                                          imageLoader: imageLoader,
                                                                          seriesRepository: seriesRepository,
                                                                          imageLoaderRepository: seriesCoversRepository))
  
  
  override func setUp() {
    GREYConfiguration.shared.setValue(5.0, forConfigKey: GREYConfigKey.interactionTimeoutDuration)
  }
}

extension MarvelExplorerTestCase {
  
  func open(viewController: UIViewController, flags: OpenViewControllerFlags = .presentModally) {
    let viewControllerToOpen = flags.contains(.embedInNavigation) ? UINavigationController(rootViewController: viewController) : viewController
    viewControllerToOpen.modalPresentationStyle = .fullScreen
    let window = (UIApplication.shared.delegate as! FakeAppDelegate).window!
    print(window)
    if flags.contains(.presentModally) {
      window.rootViewController = UIViewController()
      window.rootViewController?.present(viewControllerToOpen, animated: false, completion: nil)
    } else {
      window.rootViewController = viewControllerToOpen
    }
    window.makeKeyAndVisible()
    
  }
  
  struct OpenViewControllerFlags: OptionSet {
    let rawValue: Int
    //MARK: - Flags
    static let all: OpenViewControllerFlags = [.presentModally, .embedInNavigation]
    static let embedInNavigation = OpenViewControllerFlags(rawValue: 1 << 1)
    static let presentModally = OpenViewControllerFlags(rawValue: 1 << 0)
    
  }
}
