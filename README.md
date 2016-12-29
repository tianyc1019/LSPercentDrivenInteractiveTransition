# LSPercentDrivenInteractiveTransition
 使用UIPercentDrivenInteractiveTransition自定义导航栏的交互式动画
[我的简书](https://www.jianshu.com/p/61236afa1d88)
###### 使用
只需要将viewController加入导航器，然后正常push和pop
```
let nav = LSNavigationController.init(rootViewController: ViewController.init())
self.window?.rootViewController = nav
        
        
 let second = secondViewController.init()
 self.navigationController?.pushViewController(second, animated: true)
 ```
 
###### LSShowImgs    图片浏览demo使用如下
1、初始化动画管理器
```
fileprivate lazy var animation :LSAnimationManage = LSAnimationManage()
```

2、实现管理器的代理
```
// MARK:-弹出图片协议
protocol LSAnimationStartDelegate :class {   
   ///present前获取动画起始坐标
    func ls_getStartFrame(_ indexPath:IndexPath) -> CGRect
    /// present前获取动画结束坐标
    func ls_getEndFrame(_ indexPath:IndexPath) -> CGRect
    /// present前获取动画截图（动画利用截图实现）
    func ls_getStartImageView(_ indexPath:IndexPath) -> UIImageView
}
```
3、构建图片数组（元素是： LSPhotoItem 类型）
```
 for i in 0..<28 {
            let item : LSPhotoItem = LSPhotoItem()
            item.q_pic_url = "\(i%14)"+".jpg"
            item.z_pic_url = "\(i%14)"+".jpg"
            item.isUrl = false //用来区分网络图片还是本地图片
            self.photos.append(item)
        }
 ```
 4、点击图片展示
 ```
 ///跳转浏览图片
        let photoVc = LSPhotoController()
        // modal的转场类型
        // photoVc.modalTransitionStyle = .FlipHorizontal
        // 设置转场动画代理
        photoVc.transitioningDelegate = animation;
        photoVc.modalPresentationStyle = .custom
        photoVc.phoths = self.photos
        photoVc.indexPath = indexPath
        // 设置代理
        animation.endDelegate = photoVc
        animation.startDelegate = self
        present(photoVc, animated:true, completion: nil)
 ```
 
