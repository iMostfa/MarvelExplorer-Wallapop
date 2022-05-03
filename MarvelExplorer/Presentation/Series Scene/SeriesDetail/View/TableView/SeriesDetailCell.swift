//
//  SeriesDetailCell.swift
//  MarvelExplorer
//
//  Created by Mostfa on 03/05/2022.
//

import UIKit
import SnapKit

final class ItemDetailCell: UITableViewCell {
  static let cellID = "ItemDetailCell"
  
  let detailsText: UILabel = {
    let label = UILabel.init()
    label.numberOfLines = 0
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
 private func configure() {
    
    let inset = 10
    
    contentView.addSubview(detailsText)
    detailsText.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(inset)
    }
  }
  
}
