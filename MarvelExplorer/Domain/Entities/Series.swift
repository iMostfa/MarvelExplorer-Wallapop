//
//  Series.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation

/// Represents a single Marvel Series.
struct Series: Identifiable {
  let name: String
  let id: Int
  let description: String
  let thumbnail: Thumbnail
  let modified: String
  let comics: Int?
  
}
