//
//  secondViewController.swift
//  LSInteractiveAnimation
//
//  Created by John_LS on 2016/12/21.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit

class secondViewController: UIViewController {
    var btn_present : UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "viewController"
        self.view.backgroundColor = UIColor.blue
        
        self.transitioningDelegate = LSViewControllerTransitioning.init()
        
        
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.frame = CGRect(x:30,y: 30 ,width: 100, height: 100)
        self.view.addSubview(btn)
        btn.setTitle("pop", for: UIControlState.normal)
        btn.addTarget(self, action:#selector(pop) , for: UIControlEvents.touchUpInside)
        
        
        
        self.btn_present = UIButton.init(type: UIButtonType.custom)
        btn_present?.frame = CGRect(x:30,y: 230 ,width: 200, height: 200)
        self.view.addSubview(btn_present!)
        btn_present?.setTitle("btn_present", for: UIControlState.normal)
        btn_present?.addTarget(self, action:#selector(pre) , for: UIControlEvents.touchUpInside)
        btn_present?.setBackgroundImage(UIImage.init(named: "c2bfda7fgw1ewg5136wc8j20yi0pw416.jpg"), for: UIControlState.normal)
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
    
    func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func pre() {
        let third = thirdViewController.init()
        self.present(third, animated: true) { 
            
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return LSPresentAnimation.init()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return LSDismissAnimation.init()
    }
    
}
