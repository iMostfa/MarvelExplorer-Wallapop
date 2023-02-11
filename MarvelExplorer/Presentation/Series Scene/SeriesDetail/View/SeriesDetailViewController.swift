//
//  SeriesDetailViewController.swift
//  MarvelExplorer
//
//  Created by Mostfa on 03/05/2022.
//

import Foundation
import Combine
import UIKit
import SVProgressHUD
import SnapKit

public protocol SeriesDetailViewControllerDelegate: AnyObject {
  func showSeries(image: UIImage, frame: CGRect)
}

/// Series List View controller is used to show a list of series.
final public class SeriesDetailViewController: UIViewController {

  weak var delegate: SeriesDetailViewControllerDelegate?
  private let viewModel: SeriesDetailViewModelType
  private var cancellableBag = Set<AnyCancellable>()
  private var onAppearPublisher = PassthroughSubject<Void, Never>()
  private lazy var detailsView: SeriesDetailsView = {
    let view = SeriesDetailsView()
    view.delegate = self
    return view
  }()

  lazy var tableDataSource: SeriesDetailsDataSource = makeDataSource()
  var tableViewDelegate = SeriesDetailsTableViewDelegate()

  public init(viewModel: SeriesDetailViewModelType, delegate: SeriesDetailViewControllerDelegate) {
    self.viewModel = viewModel
    self.delegate = delegate
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func loadView() {
    view = detailsView
  }

// MARK: - View Cycle

  public override func viewDidLoad() {
    super.viewDidLoad()
    bind(to: viewModel)
    onAppearPublisher.send()
  }

  public override func viewWillDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    self.detailsView.tableHeaderView.viewWillDisAppear()
  }

  // MARK: - View Model Binding
  private func bind(to viewModel: SeriesDetailViewModelType) {

    cancellableBag.forEach { $0.cancel() }
    cancellableBag.removeAll()

    let input = SeriesDetailViewModelInput.init(onAppear: onAppearPublisher.eraseToAnyPublisher())

    let output = viewModel.transform(input: input)

    output.sink { [weak self] state in
      guard let self = self else { return }
      switch state {

      case .success(let viewModel):
        self.configureTableView(with: viewModel)
        self.detailsView.tableHeaderView.bind(to: viewModel.cover)
      }
    }.store(in: &cancellableBag)
  }

  // MARK: - Table View Setup
  func configureTableView(with details: SeriesDetailItemViewModel) {
    tableViewDelegate.headerView = detailsView.tableHeaderView

    detailsView.tableView.register(ItemDetailCell.self,
                                   forCellReuseIdentifier: ItemDetailCell.cellID)

    detailsView.tableView.dataSource = tableDataSource

    var snapshot = NSDiffableDataSourceSnapshot<SeriesDetailSection, DetailItem>.init()
    // 1- Append sections
    let sections = tableDataSource.sections

    snapshot.appendSections(sections)

    for detail in details.seriesDetails {
      switch detail {
      case .creators(let creators):
        let detailItems = creators.map { DetailItem.init(value: $0.name) }
        snapshot.appendItems(detailItems, toSection: .writers)
      case .startYear(let year), .endYear(let year):
        snapshot.appendItems([.init(value: "\(year)")], toSection: .years)

      case .description(let description):
        snapshot.appendItems([.init(value: "\(description)")], toSection: .description)

      }
    }
    detailsView.tableView.delegate = tableViewDelegate
    tableDataSource.apply(snapshot)
  }

  func makeDataSource() -> SeriesDetailsDataSource {
    let datasource = SeriesDetailsDataSource(tableView: self.detailsView.tableView) { tableView, indexPath, data in
      guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemDetailCell.self.cellID, for: indexPath) as? ItemDetailCell else {
        return .init()
      }
      cell.detailsText.text = data.value
      return cell
    }
    return datasource
  }
}

extension SeriesDetailViewController: SeriesDetailsViewDelegate {
  func onHeaderTapped(image: UIImage, frame: CGRect) {
    print("Header was tapped")
    delegate?.showSeries(image: image, frame: frame)
  }
}
