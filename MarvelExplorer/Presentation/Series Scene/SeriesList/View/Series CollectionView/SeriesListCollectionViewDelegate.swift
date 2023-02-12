//
//  SeriesListCollectionViewDelegate.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import UIKit
import Combine

final class SeriesListCollectionViewDelegate: NSObject, UICollectionViewDelegate {

  private var onPageRequest: PassthroughSubject<Void, Never>?
  private var onItemSelected: PassthroughSubject<(UICollectionViewCell, Int), Never>?
  var onScroll: (() -> Void)?

  let fetchPostsThreshold = 3

  init(onPageRequest: PassthroughSubject<Void, Never>,
       onItemSelected: PassthroughSubject<(UICollectionViewCell, Int), Never>) {
    self.onPageRequest = onPageRequest
    self.onItemSelected = onItemSelected
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    Haptics.play(.light)
    guard let cell = collectionView.cellForItem(at: indexPath) else { return }
    self.onItemSelected?.send((cell, indexPath.row))
  }

  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    self.onScroll?()

  }
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

    if let dataSourceCount = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: 0) {

      if indexPath.row == dataSourceCount - fetchPostsThreshold {
        print("should fetch more pages")
        onPageRequest?.send()

      }
    }
  }
}
