//
//  SeriesListViewModelTests.swift
//  MarvelExplorerTests
//
//  Created by Mostfa on 01/05/2022.
//

import XCTest
import Combine
@testable import MarvelExplorer

class SeriesListViewModelTests: XCTestCase {
  
  private let fetchSeriesUseCase = FetchMarvelSeriesUseCaseTypeMock()
  private let navigator = SeriesListNavigatorMock()
  private var viewModel: SeriesListViewModel!
  private var coverLoaderUseCase = LoadSeriesCoverUseCaseMock()
  private var cancellableBag: Set<AnyCancellable> = .init()
  
  override func setUpWithError() throws {
    viewModel = .init(fetchSeriesUseCase: fetchSeriesUseCase,
                      coverLoaderUseCase: coverLoaderUseCase,
                      navigator: navigator)
  }
  
  override func tearDownWithError() throws {

    viewModel = nil
  }
  
  func test_FetchSeries_onAppear() {
    //Given
    let onAppear = PassthroughSubject<(()),Never>()
    var state: SeriesListState?
    let input = SeriesListViewModelInput.init(onAppear: onAppear.eraseToAnyPublisher(),
                                              onSearch: .empty(),
                                              onSeriesSelection: .empty(),
                                              onPageRequest: .empty())
    let expectation = self.expectation(description: "Series Fetch onAppear")
    let seriesDTO = MarvelSeriesDTOResponse.loadFromFile("SeriesResponse.json")
    let series = seriesDTO.data.results.map { $0.toDomain() }
    
    coverLoaderUseCase.loadSeriesCoverForReturnValue = .just(.init())
    fetchSeriesUseCase.fetchSeriesReturnValue = .just(.success(series))

    let expectedViewModels = viewModel.viewModels(from: series)

  
    viewModel.transform(input: input)
      .sink { modifiedState in
        guard case SeriesListState.success(_) = modifiedState else { return }
        state = modifiedState
        expectation.fulfill()
      }.store(in: &cancellableBag)
    
    //When
    onAppear.send()
    
    //Then
    waitForExpectations(timeout: 1.0)
    XCTAssertEqual(state!, .success(expectedViewModels))
    
  }
  
  func test_StateIsLoading_onPageRequest() {
    //Given
    let onPageRequest: PassthroughSubject<(),Never> = .init()
    
    let input = SeriesListViewModelInput.init(onAppear: .empty(),
                                              onSearch: .empty(),
                                              onSeriesSelection: .empty(),
                                              onPageRequest: onPageRequest.eraseToAnyPublisher())
  
    var state: [SeriesListState] = []
    
    let expectation = self.expectation(description: "State is loading")
    fetchSeriesUseCase.fetchSeriesReturnValue = .just(.success([]))

    
    viewModel.transform(input: input)
      .sink(receiveCompletion: { _ in }, receiveValue: { modifiedState in
        print(modifiedState)
        state.append(modifiedState)
        //When a page request is sent, loading, and series state is being sent.
        if state.count == 2 { expectation.fulfill() }
      }).store(in: &cancellableBag)
  
    
    //When
    onPageRequest.send()


    //Then
    waitForExpectations(timeout: 1.0)
    XCTAssert(state.contains(.loading))
  
  }
  
  func test_StateIsLoading_onAppear() {
    //Given
    let onAppear: PassthroughSubject<(),Never> = .init()
    
    let input = SeriesListViewModelInput.init(onAppear: onAppear.eraseToAnyPublisher(),
                                              onSearch: .empty(),
                                              onSeriesSelection: .empty(),
                                              onPageRequest: .empty())
    
    var state: [SeriesListState] = []
    
    let expectation = self.expectation(description: "State is loading")
    fetchSeriesUseCase.fetchSeriesReturnValue = .just(.success([]))
    
    
    viewModel.transform(input: input)
      .sink(receiveCompletion: { _ in }, receiveValue: { modifiedState in
        print(modifiedState)
        state.append(modifiedState)
        //When a page request is sent, loading, and series state is being sent.
        if state.count == 2 { expectation.fulfill() }
      }).store(in: &cancellableBag)
    
    
    //When
    onAppear.send()
    
    
    //Then
    waitForExpectations(timeout: 1.0)
    XCTAssert(state.contains(.loading))
    
  }
  
  func test_returnAllSeries_IfQueryIsEmpty() {
    //Given
    let onSearch = PassthroughSubject<(String),Never>()
    
    var state: SeriesListState?
    let input = SeriesListViewModelInput.init(onAppear: .empty(),
                                              onSearch: onSearch.eraseToAnyPublisher(),
                                              onSeriesSelection: .empty(),
                                              onPageRequest: .empty())
    
    let expectation = self.expectation(description: "Series Searching When Query is empty")
    
    coverLoaderUseCase.loadSeriesCoverForReturnValue = .just(.init())
    fetchSeriesUseCase.filterSeriesQueryReturnValue = .just(.success([]))
       
    viewModel.transform(input: input)
      .sink { modifiedState in
        guard case SeriesListState.success = modifiedState else { return XCTFail("State should be success") }
        state = modifiedState
        expectation.fulfill()
      }.store(in: &cancellableBag)
    
    //When
    onSearch.send("Fantastic")
    
    //Then
    waitForExpectations(timeout: 1.0)
    XCTAssertEqual(state!, .success([]))
    
  }
  
  
}
