//
//  LoadCoverUseCase.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine
import UIKit.UIImage

protocol LoadCoverUseCaseType: AnyObject {
  func loadSeriesCover(for series: Series) -> AnyPublisher<UIImage?, Never>
}

final class LoadSeriesCoverUseCase: LoadCoverUseCaseType {
  
  private let coversRepository: MarvelSeriesCoverRepository
  
  init(coversRepository: MarvelSeriesCoverRepository) {
    self.coversRepository = coversRepository
  }
  

  func loadSeriesCover(for series: Series) -> AnyPublisher <UIImage?, Never> {
    return coversRepository.loadSeriesCover(with: series.thumbnail.url.asSecureURL.absoluteString)
  }
  
}
