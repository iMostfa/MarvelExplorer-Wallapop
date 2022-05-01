//
//  DefaultCoverRepository.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine
import UIKit.UIImage

final class DefaultSeriesCoverRepository {
  
  private let imageLoader: ImageLoaderServiceType
  
  
  init(imageLoader: ImageLoaderServiceType) {
    self.imageLoader = imageLoader
  }
  
}

extension DefaultSeriesCoverRepository: SeriesCoverRepository {
  
  func loadSeriesCover(with path: String) -> AnyPublisher<UIImage?, Never> {
    //TODO: Better handling for the errors.
    guard let url = URL.init(string: path) else { return .just(nil) }
   
    return imageLoader
      .loadImage(from: url)
      .eraseToAnyPublisher()
    
  }
  
  

  
}
