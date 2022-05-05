//
//  Series.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation

/// Represents a single Marvel Series.
public struct Series: Identifiable, Equatable {
  public let name: String
  public let id: Int
  public let description: String?
  public let thumbnail: Thumbnail
  public let modified: String
  public let startYear: Int
  public let endYear: Int
  public let type: String
  public let creators: [Creator]

  public init(name: String,
       id: Int,
       description: String?,
       thumbnail: Thumbnail,
       modified: String,
       startYear: Int,
       endYear: Int,
       type: String,
       creators: [Creator]) {
    self.name = name
    self.id = id
    self.description = description
    self.thumbnail = thumbnail
    self.modified = modified
    self.startYear = startYear
    self.endYear = endYear
    self.type = type
    self.creators = creators
  }
}
