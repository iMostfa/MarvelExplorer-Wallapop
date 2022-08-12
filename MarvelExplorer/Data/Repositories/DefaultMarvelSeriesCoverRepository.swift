//
//  DefaultCoverRepository.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine
import UIKit.UIImage
import MarvelExplorerDomain
import MarvelExplorerShared

final class DefaultMarvelSeriesCoverRepository {

  private let imageLoader: ImageLoaderServiceType

  init(imageLoader: ImageLoaderServiceType) {
    self.imageLoader = imageLoader
  }

}

extension DefaultMarvelSeriesCoverRepository: MarvelSeriesCoverRepository {

  func loadSeriesCover(with path: String) async throws -> UIImage? {
    // TODO: Better handling for the errors.
    guard let url = URL.init(string: path) else { return nil }

    return try await imageLoader
      .loadImage(from: url)

  }

}
