//
//  SeriesDetailView.swift
//  MarvelExplorer
//
//  Created by Mostfa on 03/05/2022.
//

import UIKit
import SnapKit

protocol SeriesDetailsViewDelegate: AnyObject {
  func onHeaderTapped()
}

final class SeriesDetailsView: UIView {

  weak var delegate: SeriesDetailsViewDelegate?

  let tableView: UITableView = {
    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.insetGrouped)
    tableView.accessibilityIdentifier = AccessibilityIdentifiers.SeriesDetail.tableViewID
    return tableView
  }()

  lazy var tableHeaderView: StretchyHeaderView = {
    let header = StretchyHeaderView(frame: CGRect(x: 0, y: 0,
                                                  width: self.frame.size.width,
                                                  height: 250))
    let onTap = UITapGestureRecognizer(target: self, action: #selector(onHeaderTapped))
    header.addGestureRecognizer(onTap)
    return header
  }()

  init() {
    super.init(frame: .zero)
    configureUI()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  func configureUI() {
    addSubview(tableView)
    tableView.tableHeaderView = tableHeaderView
    tableHeaderView = tableHeaderView

    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  @objc private func onHeaderTapped() {
    delegate?.onHeaderTapped()
  }
}
