//
//  LoadCoverUseCase.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine
import MarvelExplorerShared
import UIKit.UIImage

public protocol LoadCoverUseCaseType: AnyObject {
  func loadSeriesCover(for series: Series) -> AnyPublisher<UIImage?, Never>
}

final public class LoadSeriesCoverUseCase: LoadCoverUseCaseType {

  private let coversRepository: MarvelSeriesCoverRepository

  public init(coversRepository: MarvelSeriesCoverRepository) {
    self.coversRepository = coversRepository
  }

  public func loadSeriesCover(for series: Series) -> AnyPublisher <UIImage?, Never> {
    return coversRepository.loadSeriesCover(with: series.thumbnail.url.asSecureURL.absoluteString)
  }

}
