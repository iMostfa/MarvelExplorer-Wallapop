//
//  ServiceProvider.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation

class ServicesProvider {
  let network: NetworkServiceType
  let imageLoader: ImageLoaderServiceType
  let seriesRepository: MarvelSeriesRepository
  let imageLoaderRepository: SeriesCoverRepository


  static var defaultProvider: ServicesProvider {
    let network = NetworkService()
    let imageLoader = ImageLoaderService()
    let seriesRepository = DefaultSeriesRepository(networkService: network)
    let imageLoaderRepository = DefaultSeriesCoverRepository.init(imageLoader: imageLoader)
    return ServicesProvider(network: network,
                            imageLoader: imageLoader,
                            seriesRepository: seriesRepository,
                            imageLoaderRepository: imageLoaderRepository)

  }

  init(network: NetworkServiceType,
       imageLoader: ImageLoaderServiceType,
       seriesRepository: MarvelSeriesRepository,
       imageLoaderRepository: SeriesCoverRepository) {
    self.network = network
    self.imageLoader = imageLoader
    self.seriesRepository = seriesRepository
    self.imageLoaderRepository = imageLoaderRepository
  }
}
