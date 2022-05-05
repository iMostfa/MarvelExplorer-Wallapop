//
//  DefaultComposites.swift
//  MarvelExplorer
//
//  Created by Mostfa on 06/05/2022.
//

import Foundation

enum AppDelegateCompositeFactory {
  static let defaultComposites: [AppDelegateComposite] = [ TestsCompositeAppDelegate.init() ]
}
