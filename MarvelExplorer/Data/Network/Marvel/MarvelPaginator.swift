//
//  MarvelPaginator.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation

/// Any Response(Result field) from Marvel API could be assumed to be MarvelPaginator
struct MarvelPaginator<Value: Codable>: Codable {

  private(set) var limit: Int
  private(set) var count: Int
  private(set) var offset: Int
  private(set) var total: Int
  private(set) var results: [Value]

  var hasPages: Bool { return offset + count < total }

  var nextOffset: Int { hasPages ? offset + limit: offset }

}
