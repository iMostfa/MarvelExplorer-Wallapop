//
//  URL+HTTPS.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation

public extension URL {

  var isHTTP: Bool {
    return scheme?.contains("https") ?? false
  }

  var asSecureURL: URL {
    guard !isHTTP else { return self }

    let secureURL = absoluteString.replacingOccurrences(of: scheme ?? "", with: "https")
    return URL(string: secureURL)!
  }
}
