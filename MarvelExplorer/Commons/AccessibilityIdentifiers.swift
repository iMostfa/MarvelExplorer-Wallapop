//
//  AccessibilityIdentifiers.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation

/// NameSpace used for Accessibility Support, and UI Testing
enum AccessibilityIdentifiers {

  public struct SeriesList {
      public static let searchFieldID = "\(SeriesList.self).searchFieldID"
      public static let mainViewID = "mainViewID"
      public static let cellID = "\(SeriesList.self).cellId"
      public static let collectionViewID = "\(SeriesList.self).collectionViewID"
  }

}
