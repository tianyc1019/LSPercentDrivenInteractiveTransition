//
//  LSNavigationController.swift
//  LSPercentDrivenInteractiveTransition
//
//  Created by John_LS on 2016/12/22.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit

class LSNavigationController: UINavigationController , UINavigationControllerDelegate {
    var interactionInProgress = false //用于指示交互是否在进行中。
    
    ///交互控制器
    private var interactivePopTransition : LSPercentDrivenInteractiveTransition!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
        let gesture = UIScreenEdgePanGestureRecognizer(target:self,action:#selector(handleGesture(gestureRecognizer:)))
        gesture.edges = .left
        self.view.addGestureRecognizer(gesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
//    // 以下----使用UIPercentDrivenInteractiveTransition交互控制器
//        func handleGesture(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
//            var progress = gestureRecognizer.translation(in: gestureRecognizer.view?.superview).x / self.view.bounds.size.width
//            progress = min(1.0, max(0.0, progress))
//    //        let translation = gestureRecognizer.translation(in: gestureRecognizer.view?.superview)
//    //        var progress = Float(translation.x / 200)
//    //        progress = fminf(fmaxf(progress, 0.0), 1.0)
//    
//            print("\(progress)")
//            if gestureRecognizer.state == UIGestureRecognizerState.began {
//                print("Began")
//                self.interactivePopTransition = LSPercentDrivenInteractiveTransition()
//                interactionInProgress = true
//                self.popViewController(animated: true)
//            } else if gestureRecognizer.state == UIGestureRecognizerState.changed {
//                self.interactivePopTransition.update(CGFloat(progress))
//                print("Changed")
//            } else if gestureRecognizer.state == UIGestureRecognizerState.ended || gestureRecognizer.state == UIGestureRecognizerState.cancelled {
//                if progress > 0.5 {
//                    self.interactivePopTransition.finish()
//                    print("finished")
//                } else {
//                    self.interactivePopTransition.cancel()
//                    print("canceled")
//                }
//                interactionInProgress = false
//                self.interactivePopTransition = nil
//            }
//        }
    ///以下是自定义交互器
    func handleGesture(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        
        var progress = gestureRecognizer.translation(in: gestureRecognizer.view?.superview).x / self.view.bounds.size.width
        progress = min(1.0, max(0.0, progress))
        //        let translation = gestureRecognizer.translation(in: gestureRecognizer.view?.superview)
        //        var progress = Float(translation.x / 200)
        //        progress = fminf(fmaxf(progress, 0.0), 1.0)
        
        print("\(progress)")
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            print("Began")
            
            if interactionInProgress == true {
                return
            }
            self.interactivePopTransition = LSPercentDrivenInteractiveTransition()
            interactionInProgress = true
            self.popViewController(animated: true)
        } else if gestureRecognizer.state == UIGestureRecognizerState.changed {
            interactivePopTransition.update(progress)
            print("Changed")
        } else if gestureRecognizer.state == UIGestureRecognizerState.ended || gestureRecognizer.state == UIGestureRecognizerState.cancelled {
            interactivePopTransition.finishBy(cancelled: progress < 0.5)
            interactionInProgress = false
            self.interactivePopTransition = nil
        }
    }
    
    /// UINavigationControllerDelegate 以下两个协议均实现时，以第二个为准，
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        if operation == UINavigationControllerOperation.push {
//            return LSPushAnimation.init()
//        }else
        if operation == UINavigationControllerOperation.pop {
            return LSPopAnimation.init()
        }
        return nil
    }
    
    /// 当返回值为nil时，上面的协议返回的push和pop动画才会有作用   不需要自定义控制器则去掉此方法
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if interactivePopTransition != nil {
            return interactivePopTransition
        }
        return nil
    }

}
