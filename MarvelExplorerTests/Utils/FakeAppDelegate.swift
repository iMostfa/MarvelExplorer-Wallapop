//
//  FakeAppDelegate.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import UIKit

class FakeAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
  
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
      window?.backgroundColor = .green
        window?.rootViewController = UIViewController()
      window?.rootViewController?.view.backgroundColor = .blue
        window?.makeKeyAndVisible()
    
        return true
    }
}
