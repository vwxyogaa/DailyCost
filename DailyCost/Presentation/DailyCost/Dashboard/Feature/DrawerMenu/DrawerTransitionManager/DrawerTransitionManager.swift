//
//  DrawerTransitionManager.swift
//  DailyCost
//
//  Created by Panji Yoga on 08/09/23.
//

import UIKit

class DrawerTransitionManager: NSObject, UIViewControllerTransitioningDelegate {
    
    let slideAnimation = DrawerSlideAnimation()
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DrawerPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        slideAnimation.isPresenting = true
        return slideAnimation
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        slideAnimation.isPresenting = false
        return slideAnimation
    }
}
