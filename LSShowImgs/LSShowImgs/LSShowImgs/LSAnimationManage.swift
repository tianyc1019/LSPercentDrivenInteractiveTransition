//
//  LSAnimationManage.swift
//  LSShowImgs
//
//  Created by John_LS on 2016/12/26.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit

// MARK:-弹出图片协议
protocol LSAnimationStartDelegate :class {
    
    /// present前获取动画起始坐标
    func ls_getStartFrame(_ indexPath:IndexPath) -> CGRect
    /// present前获取动画结束坐标
    func ls_getEndFrame(_ indexPath:IndexPath) -> CGRect
    /// present前获取动画截图（动画利用截图实现）
    func ls_getStartImageView(_ indexPath:IndexPath) -> UIImageView
    
}
// MARK:-图片缩放消失协议
protocol LSAnimationEndDelegate : class {
    
    /// 获取当前浏览的下标
    ///
    /// - Returns: 当前浏览的下标
    func ls_getCurrentIndexPath() -> IndexPath
    /// 获取当前浏览的图片截图（动画利用截图实现）
    ///
    /// - Returns: 当前浏览的图片截图
    func ls_getEndImageView() -> UIImageView
}

class LSAnimationManage: NSObject {
    // 定义属性 
    
    /// 动画类型
    var ispresented :Bool = true
    
    /// 当前作用的下标
    var indexPath : IndexPath?
    
    /// 是否需要重新加载（true：则是图片链接需要重新加载  false：是图片不需要重新加载）
    var isUrls : Bool?
    // 设置代理
    weak var startDelegate :LSAnimationStartDelegate?
    weak var endDelegate :LSAnimationEndDelegate?
    
    func ls_showImgs(imgs : [LSPhotoItem]? , index : IndexPath? , isUrl : Bool? , formVC : UIViewController , delegate : LSAnimationStartDelegate ) {
        self.indexPath = index
        self.isUrls = isUrl
        
        ///跳转浏览图片
        let photoVc = LSPhotoController()
        // modal的转场类型
        // photoVc.modalTransitionStyle = .FlipHorizontal
        // 设置转场动画代理
        photoVc.transitioningDelegate = self;
        photoVc.modalPresentationStyle = .custom
        photoVc.phoths = imgs
        photoVc.indexPath = indexPath
        // 设置代理
        self.endDelegate = photoVc
        self.startDelegate = delegate
        formVC.present(photoVc, animated:true, completion: nil)
    }
    

    
    
}
/// 获取截图
///
/// - Parameter view: 要截图的view
/// - Returns: 截图完成后创建UIIimageView
func ls_getScreenshots(view : UIView?) -> UIImageView {
    //截屏
    UIGraphicsBeginImageContext((view?.frame.size)!)
    let ctx:CGContext = UIGraphicsGetCurrentContext()!
    view?.layer.render(in: ctx)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext();
    
    let imgView : UIImageView = UIImageView.init(image: image)
    return imgView
}

// MARK:- 根据Image计算放大之后的frame
func ls_calculateFrameWithImage(_ image :UIImage) -> CGRect {
    guard image != nil else {
        return CGRect.zero
    }
    // 1.取出屏幕的宽度和高度
    let ScreenW = UIScreen.main.bounds.width
    let ScreenH = UIScreen.main.bounds.height
    
    // 2.计算imageView的frame
    let imageW = ScreenW
    let imageH = ScreenW / image.size.width * image.size.height
    let imageX :CGFloat = 0
    let imageY :CGFloat = (ScreenH - imageH) * 0.5
    
    return CGRect(x: imageX, y: imageY, width:imageW, height: imageH)
}


// MARK: - 实现动画协议管理
extension LSAnimationManage : UIViewControllerTransitioningDelegate {
    // 为弹出的控制器做转场动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        ispresented = true
        return self
    }
    // 为消失的控制器做转场动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        ispresented = false
        return self
    }

}

// MARK: - 实现具体动画
extension LSAnimationManage : UIViewControllerAnimatedTransitioning {
    
    /// 设置动画时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    /// 动画效果
    // transitionContext : 转场上下文
    // 作用 : 可以通过上下文获取到弹出的View和消失的View
    // UITransitionContextFromViewKey : 获取消失的View
    // UITransitionContextToViewKey : 获取弹出的View
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if ispresented {
            
            // 判断代理对象是否有值
            guard let presDelegate = startDelegate , let index = indexPath else{
                return
            }
            
            let presentView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
            transitionContext.containerView.addSubview(presentView)
            presentView.alpha = 0.0
            transitionContext.containerView.backgroundColor = UIColor.black
            
            // 获取UIImageView
            let imageV :UIImageView = presDelegate.ls_getStartImageView(index)
            imageV.contentMode = UIViewContentMode.scaleAspectFit
            transitionContext.containerView.addSubview(imageV)
            // 获取图片放大起始位置
            let startCGRect :CGRect = presDelegate.ls_getStartFrame(index)
            imageV.frame = startCGRect
            
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                let endCGRect : CGRect = presDelegate.ls_getEndFrame(index)
                imageV.frame = endCGRect
            }, completion: { (isfinished:Bool) in
                imageV.removeFromSuperview()
                presentView.alpha = 1.0
                transitionContext.containerView.backgroundColor = UIColor.clear
                transitionContext.completeTransition(isfinished)
            })
        }else{
            guard let dismiDelegate = endDelegate , let presDelegate = startDelegate else{
                return
            }
            
            
            
            let dismissedView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
            dismissedView.removeFromSuperview()
            // 获取最新的indexPath
            let lastIndexPath = dismiDelegate.ls_getCurrentIndexPath()
            // 获取图片对象
            let imageView = dismiDelegate.ls_getEndImageView()
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            transitionContext.containerView.addSubview(imageView)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                // 获取缩放的终点位置
                let dismEndRect = presDelegate.ls_getStartFrame(lastIndexPath)
                if dismEndRect == CGRect.zero{
                    imageView.alpha = 0.0
                }else{
                    
                    imageView.frame = dismEndRect
                }
            }, completion: { (isfinished:Bool) in
                transitionContext.completeTransition(isfinished)
            })
        }

    }
}
