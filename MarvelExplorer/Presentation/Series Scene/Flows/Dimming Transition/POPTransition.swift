//
//  POPTransition.swift
//  MarvelExplorer
//
//  Created by Mostafa Essam on 11/2/23.
//

import UIKit

class PopTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

  let transition = PopAnimator()

  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

    transition.presenting = true

    return transition
  }
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    transition.presenting = false
    return transition
  }
}

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  let duration = 0.350
  var presenting = true
  var originFrame = CGRect.zero

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    duration
  }

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView
    let toView = transitionContext.view(forKey: .to)
    let goingToView = presenting ? toView! : transitionContext.view(forKey: .from)!

    let initialFrame = presenting ? originFrame : goingToView.frame
    let finalFrame = presenting ? goingToView.frame : originFrame

    let xScaleFactor = presenting ?
      initialFrame.width / finalFrame.width :
      finalFrame.width / initialFrame.width

    let yScaleFactor = presenting ?
      initialFrame.height / finalFrame.height :
      finalFrame.height / initialFrame.height

    let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)

    if presenting {
      goingToView.transform = scaleTransform
      goingToView.center = CGPoint(
        x: initialFrame.midX,
        y: initialFrame.midY)
      goingToView.clipsToBounds = true
    }

    goingToView.layer.cornerRadius = presenting ? 20.0 : 0.0
    goingToView.layer.masksToBounds = true

    if toView != nil {
      containerView.addSubview(toView!)
    }
    containerView.bringSubviewToFront(goingToView)

    UIView.animate(
      withDuration: duration,
      delay: 0.0,
      usingSpringWithDamping: 0.9,
      initialSpringVelocity: 1,
      animations: {
        goingToView.transform = self.presenting ? .identity : scaleTransform
        goingToView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        goingToView.layer.cornerRadius = !self.presenting ? 20.0 : 0.0
      }, completion: { _ in
        transitionContext.completeTransition(true)
    })

  }

}
