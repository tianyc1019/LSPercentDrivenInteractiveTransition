//
//  LSPercentDrivenInteractiveTransition.swift
//  LSPercentDrivenInteractiveTransition
//
//  Created by John_LS on 2016/12/22.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit

class LSPercentDrivenInteractiveTransition: UIPercentDrivenInteractiveTransition   {
    
    
    ///以下是自定义交互控制器
    var transitionContext : UIViewControllerContextTransitioning!
    var transitingView : UIView!
    
    
    
    
    /// 以下----自定义交互控制器
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        
        containerView.insertSubview((toViewController?.view)!, belowSubview: (fromViewController?.view)!)
        
        self.transitingView = fromViewController?.view

    }
    override func update(_ percentComplete: CGFloat) {
        let scale = CGFloat(fabsf(Float(percentComplete - CGFloat(1.0))))
        transitingView?.transform = CGAffineTransform(scaleX: scale, y: scale)
        transitionContext?.updateInteractiveTransition(percentComplete)
    }
    
    
    
    func finishBy(cancelled: Bool) {
        if cancelled {
            UIView.animate(withDuration: 0.4, animations: {
                self.transitingView!.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: {completed in
                self.transitionContext!.cancelInteractiveTransition()
                self.transitionContext!.completeTransition(false)
            })
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                print(self.transitingView)
                self.transitingView!.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                print(self.transitingView)
            }, completion: {completed in
                self.transitionContext!.finishInteractiveTransition()
                self.transitionContext!.completeTransition(true)
            })
        }
    }
    
}
