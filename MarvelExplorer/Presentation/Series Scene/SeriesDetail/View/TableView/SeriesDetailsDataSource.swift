//
//  SeriesDetailsDataSource.swift
//  MarvelExplorer
//
//  Created by Mostfa on 03/05/2022.
//

import UIKit

class SeriesDetailsDataSource: UITableViewDiffableDataSource<SeriesDetailSection, DetailItem> {

  let sections = [.description, SeriesDetailSection.years, .writers]

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sections[section].title.localized()
  }

}

enum SeriesDetailSection: Hashable {
  case writers, years, description

  var title: String {
    switch self {
    case .description: return "SERIESDETAIL_DESCRIPTION"
    case .writers: return "SERIESDETAIL_WRITERS"
    case .years: return "SERIESDETAIL_DURATION"
    }
  }
}

struct DetailItem: Hashable {
  let value: String
  let id = UUID.init()
}
