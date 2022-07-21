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
public protocol ImageLoaderServiceType: AnyObject {
  func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never>
}

// MARK: - ImageLoaderServiceType
public protocol ImageLoaderServiceTypeAsync: AnyObject {
  func loadImage(from url: URL) async throws -> UIImage?
}

// MARK: - Implementation for ImageLoaderServiceType
final public class ImageLoaderService: ImageLoaderServiceTypeAsync {

  private let cache: ImageCacheTypeAsync = ImageCacheActor()

  public func loadImage(from url: URL) async throws -> UIImage? {
    if let image = await cache.image(for: url) {
      print("Fetched from cache")
      return image
    }

    let (data, _) = try await URLSession.shared.data(from: url)

    guard let image = UIImage.init(data: data) else { return nil }

    await cache.insertImage(image, for: url)
    print("Image Loaded from web \(url)")

    return image
  }
}
