//
//  ImageLoaderService.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import UIKit.UIImage
import Combine

// MARK: - ImageLoaderServiceType
protocol ImageLoaderServiceType: AnyObject {
  func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never>
}

// MARK: - Implementation for ImageLoaderServiceType
final class ImageLoaderService: ImageLoaderServiceType {

  private let cache: ImageCacheType = ImageCache()

  func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
    if let image = cache.image(for: url) {
      print("Fetched from cache")
      return .just(image)
    }
    return URLSession.shared.dataTaskPublisher(for: url)
      .map { (data, _) -> UIImage? in return UIImage(data: data) }
      .catch { _ in return Just(nil) }
      .handleEvents(receiveOutput: {[unowned self] image in
        guard let image = image else { return }
        self.cache.insertImage(image, for: url)
      })
      .print("Image loading \(url):")
      .eraseToAnyPublisher()
  }
}
