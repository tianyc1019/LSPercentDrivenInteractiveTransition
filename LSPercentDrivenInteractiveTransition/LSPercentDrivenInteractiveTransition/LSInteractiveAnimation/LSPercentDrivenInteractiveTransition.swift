//
//  LSPercentDrivenInteractiveTransition.swift
//  LSPercentDrivenInteractiveTransition
//
//  Created by John_LS on 2016/12/22.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit

class LSPercentDrivenInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var interactionInProgress = false //用于指示交互是否在进行中。
    private var shouldCompleteTransition = false //需要在内部使用shouldCompleteTransition来控制过渡，随后你会看到使用方法
    private weak var navVC : UINavigationController!//交互控制器直接负责打开/关闭视图控制器，所以我们需要把当前的视图控制器存储在viewController里，便于引用
    
    func wire(to viewController: UINavigationController!) {
        self.navVC = viewController
        prepareGestureRecognizer(in: viewController.view)
    }
    private func prepareGestureRecognizer(in view : UIView)
    {
        let gesture = UIScreenEdgePanGestureRecognizer(target:self,action:#selector(handleGesture(gestureRecognizer:)))
        gesture.edges = .left
        view.addGestureRecognizer(gesture)
    }
    func handleGesture(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        var progress = gestureRecognizer.translation(in: gestureRecognizer.view?.superview).x / navVC.view.bounds.size.width
        progress = min(1.0, max(0.0, progress))
//        let translation = gestureRecognizer.translation(in: gestureRecognizer.view?.superview)
//        var progress = Float(translation.x / 200)
//        progress = fminf(fmaxf(progress, 0.0), 1.0)
        
        print("\(progress)")
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            print("Began")
            
            interactionInProgress = true
            navVC.popViewController(animated: true)
        } else if gestureRecognizer.state == UIGestureRecognizerState.changed {
            self.update(CGFloat(progress))
            print("Changed")
        } else if gestureRecognizer.state == UIGestureRecognizerState.ended || gestureRecognizer.state == UIGestureRecognizerState.cancelled {
            if progress > 0.5 {
                self.finish()
                print("finished")
            } else {
                self.cancel()
                print("canceled")
            }
            
        }
    }
}
