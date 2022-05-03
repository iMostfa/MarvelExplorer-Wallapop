//
//  SeriesDetailsDataSource.swift
//  MarvelExplorer
//
//  Created by Mostfa on 03/05/2022.
//

import UIKit


class SeriesDetailsDataSource: UITableViewDiffableDataSource<SeriesDetailSection,DetailItem> {
  
  let sections = [.description,SeriesDetailSection.years, .writers]
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sections[section].title
  }
  
}

enum SeriesDetailSection: Hashable {
  case writers, years, description
  
  var title: String {
    switch self {
    case .description: return "Series Description"
    case .writers: return "Series Writers"
    case .years: return "Series Duration"
    }
  }
}

struct DetailItem: Hashable {
  let value: String
  let id = UUID.init()
}
