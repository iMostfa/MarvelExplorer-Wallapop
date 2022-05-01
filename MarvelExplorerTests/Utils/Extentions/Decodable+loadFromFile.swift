//
//  Decodable+loadFromFile.swift
//  MarvelExplorerTests
//
//  Created by Mostfa on 01/05/2022.
//

import Foundation
@testable import MarvelExplorer

extension Decodable {
  static func loadFromFile(_ filename: String) -> Self {
    do {
      let path = Bundle(for: MarvelExplorerTests.self).path(forResource: filename, ofType: nil)!
      let data = try Data(contentsOf: URL(fileURLWithPath: path))
      return try JSONDecoder().decode(Self.self, from: data)
    } catch {
      fatalError("Error: \(error)")
    }
  }
}
