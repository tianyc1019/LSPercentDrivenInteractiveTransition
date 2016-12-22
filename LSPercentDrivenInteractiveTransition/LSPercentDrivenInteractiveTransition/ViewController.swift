//
//  ViewController.swift
//  LSPercentDrivenInteractiveTransition
//
//  Created by John_LS on 2016/12/22.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit

class ViewController: UIViewController   {
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "viewController"
        self.view.backgroundColor = UIColor.green
        
        
        
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
    
    
    
    
    
    

}

