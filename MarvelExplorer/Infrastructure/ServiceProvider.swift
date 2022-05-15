//
//  ServiceProvider.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import MarvelExplorerDomain

public class ServicesProvider {
  public let network: NetworkServiceType
  public let imageLoader: ImageLoaderServiceType
  public let seriesRepository: MarvelSeriesRepository
  public let imageLoaderRepository: MarvelSeriesCoverRepository

  static public var defaultProvider: ServicesProvider {
    let network = NetworkService()
    let imageLoader = ImageLoaderService()
    let seriesRepository = DefaultMarvelSeriesRepository(networkService: network)
    let imageLoaderRepository = DefaultMarvelSeriesCoverRepository.init(imageLoader: imageLoader)
    return ServicesProvider(network: network,
                            imageLoader: imageLoader,
                            seriesRepository: seriesRepository,
                            imageLoaderRepository: imageLoaderRepository)

  }

  init(network: NetworkServiceType,
       imageLoader: ImageLoaderServiceType,
       seriesRepository: MarvelSeriesRepository,
       imageLoaderRepository: MarvelSeriesCoverRepository) {
    self.network = network
    self.imageLoader = imageLoader
    self.seriesRepository = seriesRepository
    self.imageLoaderRepository = imageLoaderRepository
  }
}
