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

  fileprivate lazy var useCase: DefaultFetchMarvelSeriesUseCase = .init(seriesRepository: servicesProvider.seriesRepository)
  fileprivate lazy var coverLoaderUseCase: LoadCoverUseCaseType = LoadSeriesCoverUseCase.init(coversRepository: servicesProvider.imageLoaderRepository)

  init(servicesProvider: ServicesProvider = ServicesProvider.defaultProvider) {
    self.servicesProvider = servicesProvider
  }
}

extension ApplicationComponentsFactory: ApplicationFlowCoordinatorDependencyProvider {
  func seriesListNavigationController(navigator: SeriesListNavigator) -> UINavigationController {

    let seriesListVC = SeriesListViewController(viewModel: SeriesListViewModel.init(fetchSeriesUseCase: useCase,
                                                                                    coverLoaderUseCase: coverLoaderUseCase,
                                                                                    navigator: navigator))

    let navigationController = UINavigationController(rootViewController: seriesListVC)

    navigationController.navigationBar.tintColor = .label

    return navigationController
  }

  func seriesDetailsController(_ series: Series) -> UIViewController {
    let viewModel = SeriesDetailViewModel.init(series: series, coverLoaderUseCase: coverLoaderUseCase)
    let detailsVC = SeriesDetailViewController.init(viewModel: viewModel)
    return detailsVC
  }

}
