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
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! thirdViewController
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! secondViewController
        
        let destView = fromViewController.btn_present
        
        
        
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            destView?.frame = CGRect(x:0 , y:0 , width:fromViewController.view.frame.width,height:fromViewController.view.frame.height )
        }, completion: ({completed in
            transitionContext.completeTransition(true)
        }))

    
    }

}
