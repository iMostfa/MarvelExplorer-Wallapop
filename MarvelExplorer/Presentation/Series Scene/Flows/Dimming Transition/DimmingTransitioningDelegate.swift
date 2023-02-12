//
//  DimmingTransitioningDelegate.swift
//  MarvelExplorer
//
//  Created by Mostafa Essam on 11/2/23.
//

import UIKit

class DimmingTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    return DimmingPresentationController(presentedViewController: presented,
                                           presenting: presenting)
  }
}

class DimmingPresentationController: UIPresentationController {

  let dimmingView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemPurple
    view.alpha = 0
    return view
  }()

  let blurView: UIView = {
    let blurEffect = UIBlurEffect(style: .dark)
    let view = UIVisualEffectView(effect: blurEffect)
    view.alpha = 0
    return view
  }()

  @objc func onTap() {
    presentedViewController.dismiss(animated: true)
  }
  override func presentationTransitionWillBegin() {
    containerView?.addSubview(dimmingView)
    containerView?.addSubview(blurView)

    containerView?.isUserInteractionEnabled = true
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
    containerView?.addGestureRecognizer(tapGesture)
    blurView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    dimmingView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    let transitionCoordinator = presentingViewController.transitionCoordinator
    transitionCoordinator?.animate(alongsideTransition: { _ in
      self.dimmingView.alpha = 0.5
      self.dimmingView.backgroundColor = .systemPurple

    })
  }

  override func presentationTransitionDidEnd(_ completed: Bool) {
    UIView.animate(withDuration: 0.3, animations: {
      self.blurView.alpha = 0.8
      self.dimmingView.backgroundColor = .systemPurple
      self.dimmingView.alpha = 0.3
    })
  }

  override func dismissalTransitionWillBegin() {
    let transitionCoordinator = presentingViewController.transitionCoordinator
    transitionCoordinator?.animate(alongsideTransition: { _ in
      self.dimmingView.alpha = 0.0
      self.blurView.alpha = 0.0
    })
  }
}
