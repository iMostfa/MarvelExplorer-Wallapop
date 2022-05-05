//
//  ThumbnailDTO.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import MarvelExplorerDomain

/// Represent a thumbnail DTO from Marvel API
struct ThumbnailDTO: Codable {
  let path: String
  let thumbnailExtension: String

  enum CodingKeys: String, CodingKey {
    case path
    case thumbnailExtension = "extension"
  }
}

extension ThumbnailDTO {
  func toDomain() -> Thumbnail {
    return Thumbnail.init(path: path, extension: thumbnailExtension)
  }
}
