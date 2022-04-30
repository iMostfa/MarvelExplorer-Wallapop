//
//  ApplicationComponentsFactory.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import UIKit

/// The ApplicationComponentsFactory .
final class ApplicationComponentsFactory {
  
  private let servicesProvider: ServicesProvider
  
  init(servicesProvider: ServicesProvider = ServicesProvider.defaultProvider) {
    self.servicesProvider = servicesProvider
  }
}


extension ApplicationComponentsFactory: ApplicationFlowCoordinatorDependencyProvider {
  func seriesListNavigationController(navigator: SeriesListNavigator) -> UINavigationController {
    //Will be replaced later
    let vc = UIViewController.init()
    vc.view.backgroundColor = .blue
    
    let nv = UINavigationController.init()
    nv.view.backgroundColor = .green
    nv.viewControllers = [vc]
    return nv

  }
  
  func seriesDetailsController(_ series: Series) -> UIViewController {
    let detailsVC = UIViewController.init()
    detailsVC.view.backgroundColor = .blue
    return detailsVC
  }
  
  
}
