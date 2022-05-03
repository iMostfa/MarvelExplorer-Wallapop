//
//  Series.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation

/// Represents a single Marvel Series.
struct Series: Identifiable, Equatable {
  let name: String
  let id: Int
  let description: String?
  let thumbnail: Thumbnail
  let modified: String
  let startYear: Int
  let endYear: Int
  let type: String
  let creators: [Creator]

}
