//
//  LSPresentAnimation.swift
//  LSInteractiveAnimation
//
//  Created by John_LS on 2016/12/21.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit

class LSPresentAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    //UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        
        var destView: UIView!
        var destTransform: CGAffineTransform!
        containerView.insertSubview((toViewController?.view)!, aboveSubview: (fromViewController?.view)!)
        destView = toViewController?.view
        destView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        destTransform = CGAffineTransform(scaleX: 1, y: 1)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            destView.transform = destTransform
        }, completion: ({completed in
            transitionContext.completeTransition(true)
        }))

    
    }

}
