//
//  CreatorsDTO.swift
//  MarvelExplorer
//
//  Created by Mostfa on 02/05/2022.
//

import Foundation

struct CreatorsDTO: Codable {
  let items: [CreatorsItemDTO]
}

// MARK: - CreatorsItem
struct CreatorsItemDTO: Codable {
  let name, role: String
}
