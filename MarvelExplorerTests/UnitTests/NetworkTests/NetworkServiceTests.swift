//
//  NetworkServiceTests.swift
//  MarvelExplorerTests
//
//  Created by Mostfa on 01/05/2022.
//

import Foundation
import XCTest
import Combine
@testable import MarvelExplorer

class NetworkServiceTests: XCTestCase {
  
  private var cancellableBag: [AnyCancellable] = []
  
  private lazy var networkService = NetworkService(session: session)
  private lazy var session: URLSession = {
    let sessionConfig = URLSessionConfiguration.ephemeral
    sessionConfig.protocolClasses = [URLProtocolMock.self]
    return URLSession(configuration: sessionConfig)
  }()
  
  private lazy var seriesJsonData: Data = {
    let url = Bundle(for: NetworkServiceTests.self).url(forResource: "SeriesResponse", withExtension: "json")
    guard let resourceUrl = url, let data = try? Data(contentsOf: resourceUrl) else {
      XCTFail("Failed to create data object from string!")
      return Data()
    }
    return data
  }()
  private let resource = Resource<MarvelSeriesDTOResponse>.getSeries(offset: 0, limit: 0)
  
  //MARK: - Test Cycle
  override func setUpWithError() throws {
    URLProtocol.registerClass(URLProtocolMock.self)
    
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  
  func test_loadFinishedSuccessfully() {
    // Given
    var result: Result<[Series],Error>?
    let expectation = expectation(description: "Network Service expectation")
    
    URLProtocolMock.requestHandler = { request in
      let response = HTTPURLResponse(url: self.resource.url, statusCode: 200, httpVersion: nil, headerFields: nil)!
      return (response, self.seriesJsonData)
    }
    
    // When
    networkService.load(resource)
      .map(\.data.results)
      .map { $0.map { $0.toDomain() } }
      .map { series -> Result<[Series],Error> in Result.success(series)}
      .sink { _ in
        
      } receiveValue: {  seriesResult in
        result = seriesResult
        expectation.fulfill()
      }
      .store(in: &cancellableBag)
    
    //Then
    self.waitForExpectations(timeout: 1.0)
    
    guard case .success(let series) = result else { return XCTFail() }
    XCTAssertEqual(series.count, 20)
    
  }
  
  func test_loadFailedWithJsonParseError() {
    // Given
    var result: Result<[SeriesDTO], Error>?
    let expectation = self.expectation(description: "Network parsing expectation")
    
    URLProtocolMock.requestHandler = { request in
      let response = HTTPURLResponse(url: self.resource.url, statusCode: 200, httpVersion: nil, headerFields: nil)!
      return (response, Data()) // <- Notice wrong data
    }
    
    // When
    networkService.load(resource)
      .map({ response -> Result<[SeriesDTO], Error> in
        let data = response.data.results
        return Result.success(data)
      })
      .catch({ error -> AnyPublisher<Result<[SeriesDTO], Error>, Never> in .just(.failure(error)) })
        .sink(receiveValue: { value in
          result = value
          expectation.fulfill()
        }).store(in: &cancellableBag)
              
              // Then
              self.waitForExpectations(timeout: 1.0, handler: nil)

              guard case .failure(let error) = result, error is DecodingError else {
        XCTFail()
        return
      }
  }
  
  func test_loadFailedWithInternalError() {
    // Given
    var result: Result<[SeriesDTO], Error>?
    let expectation = self.expectation(description: "Network Service expectation")
    
    URLProtocolMock.requestHandler = { request in
      let response = HTTPURLResponse(url: self.resource.url, statusCode: 500, httpVersion: nil, headerFields: nil)!
      return (response, Data())
    }
    
    // When
    networkService.load(resource)
      .map({ response -> Result<[SeriesDTO], Error> in
        let data = response.data.results
        return Result.success(data)
      })
      .catch({ error -> AnyPublisher<Result<[SeriesDTO], Error>, Never> in .just(.failure(error)) })
        .sink(receiveValue: { value in
          result = value
          expectation.fulfill()
        }).store(in: &cancellableBag)
              
              // Then
              self.waitForExpectations(timeout: 1.0, handler: nil)
              
              guard case .failure(let error) = result,
            let networkError = error as? NetworkError,
            case NetworkError.dataLoadingError(500, _) = networkError else {
        XCTFail()
        return
      }
  }
  
  
}
