//
//  secondViewController.swift
//  LSInteractiveAnimation
//
//  Created by John_LS on 2016/12/21.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit

class secondViewController: LSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "viewController"
        self.view.backgroundColor = UIColor.blue
        self.transitioningDelegate = self
        
        
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.frame = CGRect(x:30,y: 30 ,width: 100, height: 100)
        self.view.addSubview(btn)
        btn.setTitle("pop", for: UIControlState.normal)
        btn.addTarget(self, action:#selector(pop) , for: UIControlEvents.touchUpInside)
        
        let btn_dismiss = UIButton.init(type: UIButtonType.custom)
        btn_dismiss.frame = CGRect(x:30,y: 230 ,width: 100, height: 100)
        self.view.addSubview(btn_dismiss)
        btn_dismiss.setTitle("btn_dismiss", for: UIControlState.normal)
        btn_dismiss.addTarget(self, action:#selector(dis) , for: UIControlEvents.touchUpInside)
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
    func dis() {
        self.dismiss(animated: true, completion: {
            
        })
    }

}
