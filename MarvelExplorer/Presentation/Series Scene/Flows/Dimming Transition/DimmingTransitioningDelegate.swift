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
    view.backgroundColor = .purple
    view.alpha = 0
    return view
  }()

  @objc func onTap() {
    presentedViewController.dismiss(animated: true)
  }
  override func presentationTransitionWillBegin() {
    containerView?.addSubview(dimmingView)
    containerView?.isUserInteractionEnabled = true
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
    containerView?.addGestureRecognizer(tapGesture)
    dimmingView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    let transitionCoordinator = presentingViewController.transitionCoordinator
    transitionCoordinator?.animate(alongsideTransition: { _ in
      self.dimmingView.alpha = 0.5
    })
  }

  override func dismissalTransitionWillBegin() {
    let transitionCoordinator = presentingViewController.transitionCoordinator
    transitionCoordinator?.animate(alongsideTransition: { _ in
      self.dimmingView.alpha = 0.0
    })
  }
}
