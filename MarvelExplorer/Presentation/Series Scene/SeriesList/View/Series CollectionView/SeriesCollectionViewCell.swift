//
//  SeriesCollectionViewCell.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import UIKit
import SnapKit
import Combine
import MarvelExplorerData

final class SeriesCollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = "RoundedCellReuseIdentifier"

  var imageLoader: ImageLoaderServiceType?
  var imageURL: String?
  var imageDownloaderTask: Task<(), Error>?
  var dateDownloader: AnyCancellable?
  var seriesCellView: SeriesCellViewComponents = .init()

  // Inits
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
//    round(radius: 8)
  }

  required init?(coder: NSCoder) {
    fatalError("Storyboards not supported.")
  }

  func configure() {
    contentView.backgroundColor = .systemGray6
    setupDetailsStack()
  }

  override func prepareForReuse() {
    print("Prepare for Reuse")
    cancelImageLoading()
  }

  func bind(to viewModel: SeriesListItemViewModel) {
    cancelImageLoading()
    seriesCellView.title.text = viewModel.title
    seriesCellView.startYear.text = viewModel.startYear
    seriesCellView.endYear.text = viewModel.endYear
    imageDownloaderTask = Task {
      let image = try await viewModel.cover
      showImage(image: image)
    }
  }

  private func showImage(image: UIImage?) {
    DispatchQueue.main.async {
      self.cancelImageLoading()
      UIView.transition(with: self.seriesCellView.thumbnailView,
                        duration: 0.3,
                        options: [.curveEaseOut, .transitionCrossDissolve],
                        animations: {
        self.seriesCellView.thumbnailView.image = image
      })
    }

  }

  func cancelImageLoading() {
    seriesCellView.thumbnailView.image = nil
    imageDownloaderTask?.cancel()
    print("Cancelling Task")
  }

}

extension SeriesCollectionViewCell {

  // MARK: - Cell Details Stacks
  private func setupDetailsStack() {
    // hStack
    let hStack = UIStackView(arrangedSubviews: [seriesCellView.startYear,
                                                seriesCellView.endYear])
    hStack.distribution = .equalSpacing
    hStack.axis = .horizontal

    // vStack
    let vStack = UIStackView(arrangedSubviews: [seriesCellView.title,
                                                hStack])
    vStack.setCustomSpacing(5, after: seriesCellView.title)
    vStack.distribution = .equalSpacing
    vStack.axis = .vertical
    vStack.translatesAutoresizingMaskIntoConstraints = false
    vStack.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    vStack.isLayoutMarginsRelativeArrangement = true
    contentView.addSubview(seriesCellView.thumbnailView)
    contentView.addSubview(vStack)

    // vStack Background
    let stackBackground = UIVisualEffectView.init(effect: UIBlurEffect.init(style: .prominent))
    stackBackground.translatesAutoresizingMaskIntoConstraints = false
    vStack.insertSubview(stackBackground, at: 0)

    // MARK: - Constraints Setup
    seriesCellView.thumbnailView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    vStack.snp.makeConstraints { make in
      make
        .horizontalEdges
        .equalToSuperview()

      make
        .bottom.equalToSuperview()
    }

    stackBackground.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

  }
}
