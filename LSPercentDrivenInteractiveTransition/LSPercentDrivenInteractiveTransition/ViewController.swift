//
//  ViewController.swift
//  LSPercentDrivenInteractiveTransition
//
//  Created by John_LS on 2016/12/22.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UINavigationControllerDelegate {
    private let swipeInteractionController = LSPercentDrivenInteractiveTransition()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "viewController"
        self.view.backgroundColor = UIColor.green
        
        self.navigationController?.delegate = self
        swipeInteractionController.wire(to:
            self.navigationController)
        
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.frame = CGRect(x:30,y: 30 ,width: 100, height: 100)
        self.view.addSubview(btn)
        btn.setTitle("push", for: UIControlState.normal)
        btn.addTarget(self, action:#selector(push) , for: UIControlEvents.touchUpInside)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func push() {
        let second = secondViewController.init()
        self.navigationController?.pushViewController(second, animated: true)
    }
    
    
    /// UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationControllerOperation.push {
            return LSPushAnimation.init()
        }else if operation == UINavigationControllerOperation.pop {
            return LSPopAnimation.init()
        }
        return nil
    }

}

