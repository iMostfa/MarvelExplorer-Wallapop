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

  static var defaultProvider: ServicesProvider {
    let network = NetworkService()
    let imageLoader = ImageLoaderService()
    return ServicesProvider(network: network, imageLoader: imageLoader)

  }

  init(network: NetworkServiceType, imageLoader: ImageLoaderServiceType) {
    self.network = network
    self.imageLoader = imageLoader
  }
}
