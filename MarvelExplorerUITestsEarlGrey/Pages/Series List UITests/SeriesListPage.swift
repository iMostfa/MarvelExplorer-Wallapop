//
//  SeriesListPage.swift
//  MarvelExplorerTests
//
//  Created by Mostfa on 02/05/2022.
//

import Foundation
/*
class SeriesListPage: Page {

  override func verify() {
    assertExists(AccessibilityIdentifiers.SeriesList.mainViewID)
  }
}

// MARK: Actions
extension SeriesListPage {
  
  @discardableResult
  func search(_ query: String) -> Self {
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.SeriesList.searchFieldID))
      .perform(grey_typeText(query))
    return dismissKeyboard()
  }
  
  @discardableResult
  func tapItem(at index: Int) -> Self {
    return performTap(withId: "\(AccessibilityIdentifiers.SeriesList.cellID)-\(index)")
  }
}


// MARK: Assertions
extension SeriesListPage {
  
  @discardableResult
  func assertScreenTitle(_ text: String) -> Self {
    EarlGrey.selectElement(with: grey_text(text)).assert(grey_sufficientlyVisible())
    return self
  }
  
  @discardableResult
  func assertSeriessCount(_ rowsCount: Int) -> Self {
    EarlGrey.selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.SeriesList.collectionViewID))
      .assert(createCollectionViewItemsAssert(rowsCount: rowsCount, inSection: 0))
    return self
  }
  
  
  private func createCollectionViewItemsAssert(rowsCount: Int, inSection section: Int) -> GREYAssertion {
    return GREYAssertionBlock(name: "CollectionViewRowAssert") { (element, error) -> Bool in
      guard let collectionView = element as? UICollectionView, collectionView.numberOfSections > section else {
        return false
      }
      let numberOfCells = collectionView.numberOfItems(inSection: section)
      return numberOfCells == rowsCount
    }
  }
  
}

*/
