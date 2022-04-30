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
    
    
    init(timestamp: String = "\(Date().timeIntervalSince1970)",
         publicKey: String = MarvelConstants.apiKey,
         privateKey: String = MarvelConstants.privateKey) {
      self.timestamp = timestamp
      self.apiKey = publicKey
      self.hash = "\(timestamp)\(privateKey)\(publicKey)".MD5()
    }
    
    enum CodingKeys: String, CodingKey {
      case timestamp = "ts"
      case apiKey = "apikey"
      case hash
    }
  }
  
}


extension Resource {
  
  /// Used to init Resource with marvel parameters
  init(url: URL, parameters: Resource.MarvelParameters = .init()) {
    let parameters = ["ts":parameters.timestamp,
                      "apikey":parameters.apiKey,
                      "hash":parameters.hash]
    self.init(url: url, parameters: parameters)
  }
}
