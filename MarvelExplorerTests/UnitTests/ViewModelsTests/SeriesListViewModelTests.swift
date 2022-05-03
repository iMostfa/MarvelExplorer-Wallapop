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
    coverLoaderUseCase.loadSeriesCoverForReturnValue = .just(.init())
  }
  
  override func tearDownWithError() throws {

    viewModel = nil
  }
  
  /// Tests that series is fetched on Appear.
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
  
  /// Tests that loading is being sent to view when requesting one more page.
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
  
  /// Tests that loading is sent on appear.
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
  
  /// Tests that all Series is returned when search is empty.
  func test_returnAllSeries_IfQueryIsEmpty() {
    //Given
    let onSearch = PassthroughSubject<(String),Never>()
    
    var state: SeriesListState?
    let input = SeriesListViewModelInput.init(onAppear: .empty(),
                                              onSearch: onSearch.eraseToAnyPublisher(),
                                              onSeriesSelection: .empty(),
                                              onPageRequest: .empty())
    
    let expectation = self.expectation(description: "Series Searching When Query is empty")
    
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
  
  
  /// tests that when a user enters a string which appears Series title it will be returned.
  func testSearchSeries_when_QueryIsInTitle() {
    //Given
    let seriesDTO = MarvelSeriesDTOResponse.loadFromFile("FilteredSeries.json")
    let series = seriesDTO.data.results.map { $0.toDomain() }

    //When
    var state: SeriesListState!
    let expectation = self.expectation(description: "Series Filtering when a year is entered")

    viewModel.filterSeries(in: series, query: "Superior").sink { modifiedState in
      state = modifiedState
      expectation.fulfill()
    }.store(in: &cancellableBag)
    
    guard let state = state, case SeriesListState.success( let filteredViewModels) = state else { return XCTFail("Didn't receive right type") }

    waitForExpectations(timeout: 1.0)

    //then
    XCTAssertEqual(filteredViewModels.count, 1)
  }
  
  /// makes sure that when a user enters a string in Series title it will be filtered
  func testSearchSeries_when_QueryIsInYear() {
    //Given
    let seriesDTO = MarvelSeriesDTOResponse.loadFromFile("FilteredSeries.json")
    let series = seriesDTO.data.results.map { $0.toDomain() }
    
    //When
    var state: SeriesListState!
    let expectation = self.expectation(description: "Series Filtering when a year is entered")

    
    viewModel.filterSeries(in: series, query: "2019").sink { modifiedState in
      state = modifiedState
      expectation.fulfill()
    }.store(in: &cancellableBag)
    
    guard let state = state, case SeriesListState.success( let filteredViewModels) = state else { return XCTFail("Didn't receive right type") }
    
    waitForExpectations(timeout: 1.0)

    //then
    XCTAssertEqual(filteredViewModels.count, 1)
  }
  
  /// tests that new results from pagination is sent correctly to the view along with the old page.
    func test_fetchSeriesPagination_afterTwoCalls() {
      
      //Given
      let seriesDTO = MarvelSeriesDTOResponse.loadFromFile("FilteredSeries.json")
      let series = seriesDTO.data.results.map { $0.toDomain() }
      fetchSeriesUseCase.fetchSeriesReturnValue = .just(.success(series))
      
      let onPageRequest = PassthroughSubject<(),Never>()
      let expectation = self.expectation(description: "Series pagination after two calls")

      var state: SeriesListState?
      let input = SeriesListViewModelInput.init(onAppear: .empty(),
                                                onSearch: .empty(),
                                                onSeriesSelection: .empty(),
                                                onPageRequest: onPageRequest.eraseToAnyPublisher())
      
      viewModel.transform(input: input)
        .filter { $0 != .loading }
        .sink { _ in
          expectation.fulfill()
        } receiveValue: { modifiedState in
          guard case SeriesListState.success = modifiedState else { return XCTFail("State should be success") }
          state = modifiedState
        }.store(in: &cancellableBag)

      
      onPageRequest.send()
      onPageRequest.send()
      onPageRequest.send(completion: .finished)

      waitForExpectations(timeout: 1.0)

      guard let state = state, case SeriesListState.success( let twoPagesItems) = state else { return XCTFail("Didn't receive right type") }

      XCTAssertEqual(twoPagesItems.count, series.count * 2)
    }

  
  /// Tests that old page is still before the new page.
  func test_fetchSeriesPagination_concatenation() {
    
    //Given
    let seriesDTO = MarvelSeriesDTOResponse.loadFromFile("FilteredSeries.json")
    let series = seriesDTO.data.results.map { $0.toDomain() }
    fetchSeriesUseCase.fetchSeriesReturnValue = .just(.success(series))
    
    let onPageRequest = PassthroughSubject<(),Never>()
    let expectation = self.expectation(description: "Series pagination after two calls")
    
    var state: SeriesListState?
    let input = SeriesListViewModelInput.init(onAppear: .empty(),
                                              onSearch: .empty(),
                                              onSeriesSelection: .empty(),
                                              onPageRequest: onPageRequest.eraseToAnyPublisher())
    
    viewModel.transform(input: input)
      .filter { $0 != .loading }
      .sink { _ in
        expectation.fulfill()
      } receiveValue: { modifiedState in
        guard case SeriesListState.success = modifiedState else { return XCTFail("State should be success") }
        state = modifiedState
      }.store(in: &cancellableBag)
    
    
    onPageRequest.send()
    fetchSeriesUseCase.fetchSeriesReturnValue = .just(.success(series.reversed()))
    onPageRequest.send()
    onPageRequest.send(completion: .finished)
    
    waitForExpectations(timeout: 1.0)
    
    guard let state = state, case SeriesListState.success( let twoPagesItems) = state else { return XCTFail("Didn't receive right type") }
    
    XCTAssertEqual(twoPagesItems.first?.title, series.first?.name)
    XCTAssertEqual(twoPagesItems.last?.title, series.first?.name)
    // which means that concatenation was done as expected, series = oldSeries + newPageSeries

  }
  
}
