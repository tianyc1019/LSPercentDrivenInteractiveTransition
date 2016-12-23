//
//  LSViewControllerTransitioning.swift
//  LSPercentDrivenInteractiveTransition
//
//  Created by John_LS on 2016/12/23.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit



class LSViewControllerTransitioning: NSObject ,UIViewControllerTransitioningDelegate{

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return LSPopAnimation.init()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return LSPushAnimation.init()
    }
}
