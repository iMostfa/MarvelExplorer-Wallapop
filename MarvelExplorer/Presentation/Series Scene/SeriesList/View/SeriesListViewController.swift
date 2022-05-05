//
//  SeriesListViewController.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine
import UIKit
import SVProgressHUD

/// Series List View controller is used to show a list of series.
final class SeriesListViewController: UIViewController {

  private let viewModel: SeriesListViewModelType
  private var cancellableBag = Set<AnyCancellable>()

  private var onAppearPublisher = PassthroughSubject<Void, Never>()
  private var onItemSelectedPublisher = PassthroughSubject<Int, Never>()
  private var onPageRequestPublisher = PassthroughSubject<(), Never>()
  private var onSearchPublisher = PassthroughSubject<String, Never>()

  private lazy var seriesCollectionViewDataSource = makeDataSource()
  private lazy var seriesCollectionViewDelegate: SeriesListCollectionViewDelegate? = .init(onPageRequest: onPageRequestPublisher,
                                                                                           onItemSelected: onItemSelectedPublisher)
  private let seriesListView = SeriesListView()

  override func loadView() {
    view = seriesListView
  }

  init(viewModel: SeriesListViewModelType) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("No Storyboard support")
  }

  // MARK: - View Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    setupDataSourcesAndDelegates()
    bind(to: viewModel)
    onAppearPublisher.send()

  }

  // MARK: - View Model Binding
  private func bind(to viewModel: SeriesListViewModelType) {

    cancellableBag.forEach { $0.cancel() }
    cancellableBag.removeAll()

    let input = SeriesListViewModelInput(onAppear: onAppearPublisher.eraseToAnyPublisher(),
                                         onSearch: onSearchPublisher.eraseToAnyPublisher(),
                                         onSeriesSelection: onItemSelectedPublisher.eraseToAnyPublisher(),
                                         onPageRequest: onPageRequestPublisher
                                         // When searching, we shouldn't make page requests.
      .filter { [weak self] in !(self?.seriesListView.searchController.isActive ?? true) }
      .eraseToAnyPublisher())

    let output = viewModel.transform(input: input)

    output.sink(receiveValue: { [weak self] state in
      guard let self = self else { return }
      self.render(state)
    }).store(in: &cancellableBag)
  }

  private func render(_ state: SeriesListState) {
    switch state {

    case .loading:
      Haptics.play(.light)
      SVProgressHUD.show()
    case .success(let series):
      SVProgressHUD.dismiss()
      Haptics.play(.light)
      self.update(with: series)
    case .failure:
      assertionFailure("To be implemented: Show alert here..")
      return
    }
  }

  func update(with series: [SeriesListItemViewModel], animate: Bool = true) {
    DispatchQueue.main.async {
      var snapshot = SeriesSnapshot.init()
      snapshot.appendSections([.main])
      snapshot.appendItems(series, toSection: .main)
      self.seriesCollectionViewDataSource.apply(snapshot, animatingDifferences: animate)
    }
  }

  private func setupDataSourcesAndDelegates() {

    seriesListView.seriesCollectionView.register(SeriesCollectionViewCell.self, forCellWithReuseIdentifier: SeriesCollectionViewCell.reuseIdentifier)
    seriesListView.seriesCollectionView.dataSource = seriesCollectionViewDataSource
    seriesListView.seriesCollectionView.delegate = seriesCollectionViewDelegate
    seriesListView.searchController.searchBar.delegate = self
    seriesListView.searchController.searchResultsUpdater = self

  }

  private func configureUI() {
    definesPresentationContext = true
    title = "SERIESLIST_NAV_TITLE".localized()
    navigationItem.searchController = self.seriesListView.searchController
    seriesListView.searchController.isActive = false
    seriesCollectionViewDelegate?.onScroll = { [weak self] in
      self?.seriesListView.searchController.isActive = false
      self?.seriesListView.searchController.searchBar.resignFirstResponder()

    }
  }

}

extension SeriesListViewController {

  // MARK: - Collection View Data Source
  private func makeDataSource() -> SeriesListCollectionViewDataSource {

    let dataSource = SeriesListCollectionViewDataSource.init(collectionView: seriesListView.seriesCollectionView) { collectionView, indexPath, viewModel in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeriesCollectionViewCell.reuseIdentifier,
                                                          for: indexPath) as? SeriesCollectionViewCell
      else { assertionFailure("Failed to dequeue")
        return .init()
      }
      cell.accessibilityIdentifier = AccessibilityIdentifiers.SeriesList.cellID + "-\(indexPath.row)"
      cell.bind(to: viewModel)

      return cell
    }

    return dataSource
  }
}

// MARK: - Search Delegate

extension SeriesListViewController: UISearchBarDelegate, UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    self.onSearchPublisher.send(searchController.searchBar.text ?? "")
  }

}
