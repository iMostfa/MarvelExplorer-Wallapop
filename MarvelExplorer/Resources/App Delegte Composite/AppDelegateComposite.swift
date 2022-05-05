//
//  AppDelegateComposite.swift
//  MarvelExplorer
//
//  Created by Mostfa on 06/05/2022.
//

import UIKit

typealias AppDelegateComposite = UIResponder & UIApplicationDelegate

class CompositeAppDelegate: AppDelegateComposite {
  private let composites: [AppDelegateComposite]

  init(composites: [AppDelegateComposite]) {
    self.composites = composites
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    return true
  }
}
