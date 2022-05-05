//
//  String+Localizable.swift
//  MarvelExplorer
//
//  Created by Mostfa on 04/05/2022.
//

import Foundation

public extension String {
  func localized(on bundle: Bundle = .main, params: CVarArg ... ) -> String {
    let format = NSLocalizedString(self, comment: "")
    return String.localizedStringWithFormat(format,
                                     params)
  }

  /// Returns an localized version of the string
  /// - Parameter bundle: bundle which contains the localizable file
  func localized(on bundle: Bundle = .main ) -> String {
    let format = NSLocalizedString(self, comment: "")
    return String.localizedStringWithFormat(format,
                                            [])
  }
}
