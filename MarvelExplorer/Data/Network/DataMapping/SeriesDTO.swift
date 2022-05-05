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
  let thumbnail: ThumbnailDTO
  let creators: CreatorsDTO

  enum CodingKeys: String, CodingKey {
    case id, title
    case resultDescription = "description"
    case startYear, endYear, type, thumbnail, creators
  }

}

extension SeriesDTO {
  func toDomain() -> Series {
    let creators = self.creators.items.map { Creator.init(name: $0.name, role: $0.role) }

   return Series.init(name: title,
          id: id,
          description: resultDescription,
          thumbnail: thumbnail.toDomain(),
          modified: "modified.description",
          startYear: startYear,
          endYear: endYear,
          type: type, creators: creators)
  }
}
