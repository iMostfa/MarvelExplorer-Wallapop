//
//  Resource.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation

struct Resource<T: Codable> {
  let url: URL
  let parameters: [String: CustomStringConvertible]
  var request: URLRequest? {
    guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
      return nil
    }
    components.queryItems = parameters.keys.map { key in
      URLQueryItem(name: key, value: parameters[key]?.description)
    }
    guard let url = components.url else {
      return nil
    }
    return URLRequest(url: url)
  }

  init(url: URL, parameters: [String: CustomStringConvertible] = [:]) {
    self.url = url
    self.parameters = parameters
  }
}
