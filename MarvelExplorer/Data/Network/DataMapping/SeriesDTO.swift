//
//  SeriesResponse.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation

/// Represents a DTO object fetched from MarvelAPI
struct SeriesDTO: Codable {
  
  let id: Int
  let title: String
  let resultDescription: String?
  let startYear, endYear: Int
  let type: String
  let modified: Date
  let thumbnail: ThumbnailDTO
  
  enum CodingKeys: String, CodingKey {
    case id, title
    case resultDescription = "description"
    case startYear, endYear, type, modified, thumbnail
  }
  
}


extension SeriesDTO {
  func toDomain() -> Series {
    .init(name: title,
          id: id,
          description: resultDescription,
          thumbnail: thumbnail.toDomain(),
          modified: modified.description,
          startYear: startYear,
          endYear: endYear,
          type: type,
          comics: nil)
  }
}
