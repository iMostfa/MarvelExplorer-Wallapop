//
//  Resource+MarvelParameters.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation

extension Resource {
  /// MarvelParameters specifies all parameters that should be sent with a
 
  // TODO: Support Value, as a generic type to be sent along with the paraemters
  
  struct MarvelParameters: Codable {
    
    private(set) var apiKey: String
    private(set) var timestamp: String
    private(set) var hash: String
    private(set) var offset: Int?
    private(set) var limit: Int?
 
    
    init(timestamp: String = "\(Date().timeIntervalSince1970)",
         publicKey: String = MarvelConstants.apiKey,
         privateKey: String = MarvelConstants.privateKey,
         offset: Int? = nil,
         limit: Int? = nil) {
      self.timestamp = timestamp
      self.apiKey = publicKey
      self.hash = "\(timestamp)\(privateKey)\(publicKey)".MD5()
      self.offset = offset
      self.limit = limit
    }
    
    enum CodingKeys: String, CodingKey {
      case timestamp = "ts"
      case apiKey = "apikey"
      case hash
      case limit, offset
    }
  }
  
}


extension Resource {
  
  /// Used to init Resource with marvel parameters
  init(url: URL, parameters: Resource.MarvelParameters) {
    var parametersDict = ["ts":parameters.timestamp,
                      "apikey":parameters.apiKey,
                      "hash":parameters.hash]
    
    if let offset = parameters.offset {
      parametersDict["offset"] = "\(offset)"
    }
    
    if let limit = parameters.limit {
      parametersDict["limit"] = "\(limit)"
    }
    
    self.init(url: url, parameters: parametersDict)
  }
}
