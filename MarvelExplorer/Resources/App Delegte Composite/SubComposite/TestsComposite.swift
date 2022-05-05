//
//  TestsComposite.swift
//  MarvelExplorer
//
//  Created by Mostfa on 06/05/2022.
//

import UIKit

/// When executing UI Tests, some modifications might be needed for faster execution.
class TestsCompositeAppDelegate: AppDelegateComposite {
  func applicationDidFinishLaunching(_ application: UIApplication) {
    if ProcessInfo.processInfo.arguments.contains("UITests") {
      UIApplication.shared.windows.first?.layer.speed = 100
    }
  }
}
