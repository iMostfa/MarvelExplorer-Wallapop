//
//  SeriesListCollectionViewDelegate.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import UIKit
import Combine

typealias SeriesSnapshot = NSDiffableDataSourceSnapshot<SeriesDataSourceSection,SeriesListItemViewModel>

  enum SeriesDataSourceSection {
    case main
  }


/// SeriesDataSource is a subclass of UICollectionViewDiffableDataSource<SeriesDataSourceSection, SeriesListItemViewModel>, incase some Data sources functions needed to be implemented.
/// and as a type-alias around the generic.
class SeriesDataSource: UICollectionViewDiffableDataSource<SeriesDataSourceSection, SeriesListItemViewModel> { }

class SeriesListCollectionViewDelegate: NSObject, UICollectionViewDelegate {
  
  private var onPageRequest: PassthroughSubject<Void, Never>?
  private var onItemSelected: PassthroughSubject<Int, Never>?
  var onScroll: (() -> Void)?
  
  init(onPageRequest: PassthroughSubject<Void, Never>,
       onItemSelected: PassthroughSubject<Int, Never>) {
    self.onPageRequest = onPageRequest
    self.onItemSelected = onItemSelected
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    Haptics.play(.light)
    self.onItemSelected?.send(indexPath.row)
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    self.onScroll?()
    
  }
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
    if let dataSourceCount = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: 0) {
      if indexPath.row == dataSourceCount - 3 {
        print("Fetching more pages")
        onPageRequest?.send()
      
      }
    }
  }
}
