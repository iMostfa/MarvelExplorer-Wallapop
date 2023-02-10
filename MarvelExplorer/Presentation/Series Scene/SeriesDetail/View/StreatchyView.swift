//
//  StreatchyView.swift
//  MarvelExplorer
//
//  Created by Mostfa on 03/05/2022.
//

import Foundation
import UIKit
import Combine
/// Stretchy table view header
final class StretchyHeaderView: UIView {

  // MARK: - View properties
  private let blurEffectView: UIVisualEffectView = {
    let visualEffect = UIBlurEffect.init(style: .light)
    let effectView = UIVisualEffectView.init(effect: visualEffect)
    return effectView
  }()

  private var cancellableBag: Set<AnyCancellable> = .init()

  public let imageView: UIImageView = {
    let imageView = UIImageView.init()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true

    return imageView
  }()

  // MARK: - View Animator
  private var viewAnimator: UIViewPropertyAnimator?
  var blurFactor = 0.4

  // MARK: - View Constraints

  private var imageViewHeight = NSLayoutConstraint()
  private var imageViewBottom = NSLayoutConstraint()
  private var containerView = UIView()
  private var containerViewHeight = NSLayoutConstraint()

  var heightBeforeDragging: CGFloat = .infinity

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setViewConstraints()
    setupAccessibility()
  }

  required init?(coder: NSCoder) {
    fatalError("No storyboard support")
  }

  private func setupAccessibility() {
    accessibilityIdentifier = AccessibilityIdentifiers.SeriesDetail.headerID
    blurEffectView.accessibilityIdentifier = AccessibilityIdentifiers.SeriesDetail.headerBlur

  }

  private func setupViews() {
    addSubview(containerView)
    containerView.addSubview(imageView)

    self.imageView.addSubview(self.blurEffectView)

    self.blurEffectView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    blurEffectView.alpha = 0

    viewAnimator = UIViewPropertyAnimator.init(duration: 0.5, curve: .easeInOut)

    viewAnimator?.addAnimations { [weak self] in
      self?.blurEffectView.alpha = 1
    }
  }

  func bind(to imagePublisher: AnyPublisher<UIImage?, Never>) {
    imagePublisher
      .receive(on: RunLoop.main)
      .sink { [weak self] image in
      guard let self = self else { return }
      self.imageView.image = image
    }.store(in: &cancellableBag)
  }

  /// Sets up view constraints
  private func setViewConstraints() {
    NSLayoutConstraint.activate([
      widthAnchor.constraint(equalTo: containerView.widthAnchor),
      centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      heightAnchor.constraint(equalTo: containerView.heightAnchor)
    ])

    containerView.translatesAutoresizingMaskIntoConstraints = false

    containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true

    containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)

    containerViewHeight.isActive = true

    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageViewBottom = imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
    imageViewBottom.isActive = true
    imageViewHeight = imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
    imageViewHeight.isActive = true

  }

  public func scrollViewDidEndDragging(scrollView: UIScrollView) {
    self.heightBeforeDragging = .infinity
  }
  public func viewWillDisAppear() {
    self.viewAnimator?.stopAnimation(true)

  }
  public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
    self.heightBeforeDragging = offsetY
  }
  /// Notify view of scroll change from container
  public func scrollViewDidScroll(scrollView: UIScrollView) {
    // in most cases scrollViewContentInset is zero, but it's taken in calculations.
    let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
    containerView.clipsToBounds = offsetY <= 0
    imageViewBottom.constant = offsetY >= 0 ? 0: -offsetY / 2
    imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)

    DispatchQueue.main.async {
      let value = (1 - (offsetY / (self.heightBeforeDragging)))
      self.viewAnimator?.fractionComplete = -1 * value * self.blurFactor
    }
  }

}
