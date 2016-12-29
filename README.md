# LSPercentDrivenInteractiveTransition
 使用UIPercentDrivenInteractiveTransition自定义导航栏的交互式动画
https://www.jianshu.com/p/61236afa1d88
只需要将viewController加入导航器，然后正常push和pop


let nav = LSNavigationController.init(rootViewController: ViewController.init())
self.window?.rootViewController = nav
        
        
 let second = secondViewController.init()
 self.navigationController?.pushViewController(second, animated: true)

LSShowImgs    图片浏览demo
