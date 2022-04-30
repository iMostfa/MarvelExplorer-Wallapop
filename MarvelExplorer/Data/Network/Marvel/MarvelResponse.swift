//
//  MarvelResponse.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation

struct MarvelResponse<Value: Codable>: Codable {
  let code: Int
  let status: String
  let data: MarvelPaginator<Value>
}
