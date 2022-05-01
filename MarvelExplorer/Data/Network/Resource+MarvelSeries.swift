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
  
  static func getSeries(offset: Int?, limit: Int?) -> Resource  {
    let url = MarvelConstants.baseUrl.appendingPathComponent("/series")
    let marvelParameters = MarvelParameters.init(offset: offset, limit: limit)
    return Resource(url: url, parameters: marvelParameters)
  }
  
}

