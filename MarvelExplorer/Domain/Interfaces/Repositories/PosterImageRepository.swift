//
//  MarvelSeriesCoverRepository.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine
import UIKit.UIImage

/// Used to provide a cover data for a series
public protocol MarvelSeriesCoverRepository: AnyObject {
  func loadSeriesCover(with path: String) async throws -> UIImage?

}
