//
//  AppDelegate.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var appCoordinator: ApplicationFlowCoordinator!
  var composites = AppDelegateCompositeFactory.defaultComposites

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    // MARK: - Composites
    composites.forEach { $0.applicationDidFinishLaunching?(application) }

    // MARK: - App coordinator
    let window = UIWindow(frame: UIScreen.main.bounds)
    appCoordinator = ApplicationFlowCoordinator(window: window,
                                                dependencyProvider: ApplicationComponentsFactory.init())
    appCoordinator.start()
    self.window = window
    self.window?.makeKeyAndVisible()
    return true
  }

}
