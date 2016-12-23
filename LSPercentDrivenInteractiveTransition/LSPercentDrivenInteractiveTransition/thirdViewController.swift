//
//  thirdViewController.swift
//  LSPercentDrivenInteractiveTransition
//
//  Created by John_LS on 2016/12/23.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit

class thirdViewController: UIViewController {
    var btn_dismiss : UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.btn_dismiss = UIButton.init(type: UIButtonType.custom)
        btn_dismiss?.frame = CGRect(x:0,y: 0 ,width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(btn_dismiss!)
        btn_dismiss?.setTitle("btn_dismiss", for: UIControlState.normal)
        btn_dismiss?.addTarget(self, action:#selector(dis) , for: UIControlEvents.touchUpInside)
        btn_dismiss?.setBackgroundImage(UIImage.init(named: "c2bfda7fgw1ewg5136wc8j20yi0pw416.jpg"), for: UIControlState.normal)
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
    func dis() {
        self.dismiss(animated: true) { 
            
        }

    }

}
