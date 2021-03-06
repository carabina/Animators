//
//  BottomSlideAnimationDelegate.swift
//  Animators
//
//  Created by Anton Plebanovich on 5/25/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit


/// Delegation object for bottom slide presentation and navigation animations. 
/// Call `configureNavigationAnimations(navigationController:)` to configure navigation animations or
/// `configurePresentationAnimations(viewController:)` to configure presentation animations.
///
/// It fades underlaying view so check your window or navigation controller's view background color.
public final class BottomSlideAnimationDelegate: NSObject {
    
    //-----------------------------------------------------------------------------
    // MARK: - Class Properties
    //-----------------------------------------------------------------------------
    
    public static var sharedInstance = BottomSlideAnimationDelegate()
    
    //-----------------------------------------------------------------------------
    // MARK: - Class Methods
    //-----------------------------------------------------------------------------
    
    /// Use this method to configure UINavigationController push/pop animations
    public static func configureNavigationAnimations(navigationController: UINavigationController) {
        navigationController.delegate = sharedInstance
    }
    
    /// Use this method to configure UIViewController present/dismiss animations
    public static func configurePresentationAnimations(viewController: UIViewController) {
        viewController.modalPresentationStyle = .custom
        viewController.modalPresentationCapturesStatusBarAppearance = true
        viewController.transitioningDelegate = sharedInstance
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    final fileprivate var bottomSlideInAnimator = BottomSlideInAnimator()
    final fileprivate var bottomSlideOutAnimator = BottomSlideOutAnimator()
}

//-----------------------------------------------------------------------------
// MARK: - UIViewControllerAnimatedTransitioning
//-----------------------------------------------------------------------------

extension BottomSlideAnimationDelegate: UIViewControllerTransitioningDelegate {
    public final func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return bottomSlideInAnimator
    }
    
    public final func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return bottomSlideOutAnimator
    }
}

//-----------------------------------------------------------------------------
// MARK: - UINavigationControllerDelegate
//-----------------------------------------------------------------------------

extension BottomSlideAnimationDelegate: UINavigationControllerDelegate {
    public final func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return bottomSlideInAnimator
        case .pop:
            return bottomSlideOutAnimator
        case .none:
            return nil
        }
    }
}
