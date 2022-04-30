//
//  AppDelegate.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var appCoordinator: ApplicationFlowCoordinator!



  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    let window = UIWindow(frame: UIScreen.main.bounds)
    appCoordinator = ApplicationFlowCoordinator(window: window,
                                                dependencyProvider: ApplicationComponentsFactory.init())
    appCoordinator.start()
    self.window = window
    self.window?.makeKeyAndVisible()
    return true
  }

}

