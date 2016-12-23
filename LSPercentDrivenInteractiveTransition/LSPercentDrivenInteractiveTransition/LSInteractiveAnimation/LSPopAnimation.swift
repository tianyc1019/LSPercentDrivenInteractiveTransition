//
//  LSPopAnimation.swift
//  JLHomeOfAcne
//
//  Created by John_LS on 2016/12/21.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit

class LSPopAnimation: NSObject ,UIViewControllerAnimatedTransitioning  {
    //UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        
        var destView: UIView!
        var toView : UIView!
        containerView.insertSubview((toViewController?.view)!, belowSubview: (fromViewController?.view)!)
        destView = fromViewController?.view
        destView.frame = CGRect(x:0,y:0,width:destView.frame.width,height:destView.frame.height)
        toView = toViewController?.view
        toView.frame = CGRect(x:-200,y:0,width:destView.frame.width,height:destView.frame.height)

        
//        var destTransform: CGAffineTransform!
//        destTransform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
//            destView.transform = destTransform
            destView.frame = CGRect(x:(fromViewController?.view.frame.width)!,y:0,width:destView.frame.width,height:destView.frame.height)
            toView.frame = CGRect(x:0,y:0,width:destView.frame.width,height:destView.frame.height)
        }, completion: ({completed in
            transitionContext.completeTransition(true)
        }))
    }
}
