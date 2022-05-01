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
  let imageLoaderRepository: MarvelSeriesCoverRepository


  static var defaultProvider: ServicesProvider {
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
