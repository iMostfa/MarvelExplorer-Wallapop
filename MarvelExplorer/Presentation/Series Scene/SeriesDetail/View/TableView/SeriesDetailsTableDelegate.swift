//
//  SeriesDetailTableDelegate.swift
//  MarvelExplorer
//
//  Created by Mostfa on 03/05/2022.
//

import UIKit

final class SeriesDetailsTableViewDelegate: NSObject, UITableViewDelegate {

  deinit {
    debugPrint("Table View Delegate was removed.")
  }

  weak var headerView: StretchyHeaderView?

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    headerView?.scrollViewDidEndDragging(scrollView: scrollView)
  }

  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    headerView?.scrollViewWillBeginDragging(scrollView: scrollView)
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 10
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    headerView?.scrollViewDidScroll(scrollView: scrollView)
  }
}
