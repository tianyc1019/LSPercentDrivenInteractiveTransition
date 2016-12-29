# LSPercentDrivenInteractiveTransition
 使用UIPercentDrivenInteractiveTransition自定义导航栏的交互式动画
[我的简书](https://www.jianshu.com/p/61236afa1d88)
###### 使用
只需要将viewController加入导航器，然后正常push和pop```
let nav = LSNavigationController.init(rootViewController: ViewController.init())
self.window?.rootViewController = nav
        
        
 let second = secondViewController.init()
 self.navigationController?.pushViewController(second, animated: true)```
 
###### LSShowImgs    图片浏览demo使用如下
1、初始化动画管理器```
fileprivate lazy var animation :LSAnimationManage = LSAnimationManage()```

2、实现管理器的代理
```// MARK:-弹出图片协议
protocol LSAnimationStartDelegate :class {   
     present前获取动画起始坐标
    func ls_getStartFrame(_ indexPath:IndexPath) -> CGRect
    /// present前获取动画结束坐标
    func ls_getEndFrame(_ indexPath:IndexPath) -> CGRect
    /// present前获取动画截图（动画利用截图实现）
    func ls_getStartImageView(_ indexPath:IndexPath) -> UIImageView
    
}````
    func ls_getStartFrame(_ indexPath: IndexPath) -
