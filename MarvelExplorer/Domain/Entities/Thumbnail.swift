//
//  Thumbnail.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation

public struct Thumbnail: Equatable {
  public let path: String
  public let `extension`: String

  /// URL of Thumbnail
  public var url: URL {
    return URL(string: path+"."+`extension`)!
  }

  public init(path: String, `extension`: String) {
    self.path = path
    self.`extension` = `extension`
  }
}
