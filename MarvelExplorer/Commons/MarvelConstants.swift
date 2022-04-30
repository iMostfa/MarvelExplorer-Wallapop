//
//  MarvelConstants.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Keys

struct MarvelConstants {
  static let apiKey = MarvelExplorerKeys().marvelPublicKey
  static let privateKey = MarvelExplorerKeys().marvelPrivateKey
  static let baseUrl = URL(string: "https://gateway.marvel.com:443/v1/public")!
}
