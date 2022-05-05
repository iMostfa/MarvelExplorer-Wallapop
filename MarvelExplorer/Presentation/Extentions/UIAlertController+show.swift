//
//  UIAlertController+show.swift
//  MarvelExplorer
//
//  Created by Mostfa on 06/05/2022.
//

import Foundation
import UIKit

public extension UIAlertController {

  static func show(message: String,
            title: String,
            action: UIAlertAction = .init(title: "DEFAULT_ALERT_OK".localized(), style: .default),
                   on viewController: UIViewController) {
    let controller = UIAlertController.init(title: title ,
                                            message: message,
                                            preferredStyle: .alert)
    controller.addAction(action)

    viewController.present(controller, animated: true)
  }
}
