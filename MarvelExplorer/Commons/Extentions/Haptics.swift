//
//  Haptics.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//


import Foundation
import UIKit

class Haptics {
  
  static func play(_ feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
    UIImpactFeedbackGenerator(style: feedbackStyle).impactOccurred()
  }
  
  static func notify(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
    UINotificationFeedbackGenerator().notificationOccurred(feedbackType)
  }
}
