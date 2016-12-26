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
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to) else {
                ///预防rootviewcontroller触发
                return
        }
        
        var fromView: UIView!
        var toView : UIView!
        containerView.insertSubview((toViewController.view)!, belowSubview: (fromViewController.view)!)
        fromView = fromViewController.view
        fromView.frame = CGRect(x:0,y:0,width:fromView.frame.width,height:fromView.frame.height)
        toView = toViewController.view
        toView.frame = CGRect(x:-200,y:0,width:fromView.frame.width,height:fromView.frame.height)

        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromView.frame = CGRect(x:(fromView.frame.width),y:0,width:fromView.frame.width,height:fromView.frame.height)
            toView.frame = CGRect(x:0,y:0,width:toView.frame.width,height:toView.frame.height)
        }, completion: ({completed in
            transitionContext.completeTransition(true)
        }))
    }
}
