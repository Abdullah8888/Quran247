//
//  SideMenuTransition.swift
//  Quran247
//
//  Created by Jimoh Babatunde  on 12/05/2020.
//  Copyright © 2020 Dawah Nigeria. All rights reserved.
//

import Foundation
import UIKit

class SideMenuTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var isPresenting = false
    static let sharedInstance = SideMenuTransition()
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) else { return }
        
        let containerView = transitionContext.containerView
        
        let finalWidth = toViewController.view.bounds.width * 0.8
        let finalHeight = toViewController.view.bounds.height
        
        if isPresenting {
            // Add the Menu View to the Container
            containerView.addSubview(toViewController.view)
            
            //Init frame off the screen , i.e the Menu View will be at -x off the screen
            toViewController.view.frame = CGRect(x: -finalWidth, y: 40.0, width: finalWidth, height: finalHeight)
        }
        
        //Animate on to the screen i.e slide in
        let transform = {
            toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
            fromViewController.view.alpha = 2
            print("1")
        }
        
        //Animate back off the screen, i.e slide out
        let identity = {
            fromViewController.view.transform = .identity
            print("2")
        }
        
        let duration = transitionDuration(using: transitionContext)
        print("the duration is \(duration)")
        let isCancelled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration, animations: {
            if self.isPresenting {
                transform()
                fromViewController.view.alpha = 0.4
                fromViewController.view.isHidden = false
            }
            else {
                identity()
                toViewController.view.alpha = 1.0
            }
        }) {    (_) in
            transitionContext.completeTransition(!isCancelled)
        }
    }
}
