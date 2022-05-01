//
//  ImageLoaderMock.swift
//  MarvelExplorerTests
//
//  Created by Mostfa on 01/05/2022.
//

import Foundation
import XCTest
import Combine
@testable import MarvelExplorer


class ImageLoaderServiceTypeMock: ImageLoaderServiceType {
  
  //MARK: - Load Image Mock
  
  var loadImageUsingClosure: ((URL) -> AnyPublisher<UIImage?, Never>)?
  var loadImageCallsCount = 0
  var loadImageNumberOfCalls: Bool {
    return loadImageCallsCount > 0
  }
  var loadImageUsingURL: URL?
  var loadImageInvocations: [URL] = []
  var loadImageReturnValue: AnyPublisher<UIImage?, Never>!

  func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
    loadImageCallsCount += 1
    loadImageUsingURL = url
    loadImageInvocations.append(url)
    return loadImageUsingClosure.map({ $0(url) }) ?? loadImageReturnValue
  }
  
  
  
}
