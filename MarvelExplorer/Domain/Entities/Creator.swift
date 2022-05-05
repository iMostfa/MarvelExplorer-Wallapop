//
//  Creator.swift
//  MarvelExplorer
//
//  Created by Mostfa on 02/05/2022.
//

import Foundation

public struct Creator: Equatable, Hashable {
  public let name, role: String

  public init(name: String,
              role: String) {
    self.name = name
    self.role = role
  }
}
