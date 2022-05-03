//
//  SeriesDetailView.swift
//  MarvelExplorer
//
//  Created by Mostfa on 03/05/2022.
//

import UIKit
import SnapKit

class SeriesDetailsView: UIView {
  
  let tableView: UITableView = {
    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.insetGrouped)
    return tableView
  }()
  
  lazy var tableHeaderView: StretchyHeaderView = {
    let header = StretchyHeaderView(frame: CGRect (x: 0, y: 0,
                                                   width: self.frame.size.width,
                                                   height: 250))
    return header
  }()
  
  func configureUI() {
    addSubview(tableView)
    tableView.tableHeaderView = tableHeaderView
    tableHeaderView = tableHeaderView
    
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
}
