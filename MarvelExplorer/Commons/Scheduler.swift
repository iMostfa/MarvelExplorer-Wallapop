//
//  Scheduler.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation

/// Used as a namespace
public enum Scheduler {

  static public var backgroundWorkScheduler: OperationQueue = {
    let operationQueue = OperationQueue()
    operationQueue.maxConcurrentOperationCount = 20
    operationQueue.qualityOfService = QualityOfService.userInitiated
    return operationQueue
  }()

  static public let mainScheduler = RunLoop.main

}
