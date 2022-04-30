//
//  Resource+MarvelSeries.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine
import CryptoKit

extension Resource {
  
  static func getSeries() -> Resource  {
    let url = MarvelConstants.baseUrl.appendingPathComponent("/series")
    return Resource(url: url)
  }
  
}

