//
//  LSZoomView.swift
//  LSShowImgs
//
//  Created by John_LS on 2016/12/27.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit
import Kingfisher


// MARK:-弹出图片协议
protocol LSZoomDelegate :class {
    
    /// 单机手势相应
    func ls_tapClick()
    
    
}

class LSZoomView: UIControl {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    fileprivate let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    fileprivate let screenHeight: CGFloat = UIScreen.main.bounds.size.height
    fileprivate let maxScale: CGFloat = 2.0 // 最大的缩放比例
    fileprivate let minScale: CGFloat = 1.0 // 最小的缩放比例
    
    // MARK: - Public property
    var imageView: UIImageView?
    var scrollView: UIScrollView?
    public var zoomDelegate : LSZoomDelegate?
    // 要显示的图片(链接或者地址)
    var photo : LSPhotoItem? {
        didSet{
            guard let photo = photo else {
                return
            }
            backScale()
            if photo.isUrl! {
                ///网络图片
                
                
                self.scrollView?.isUserInteractionEnabled = false
                /// 从网络加载图片
                ///通过连接加载图片 现将小图显示，然后请求网络大图，请求完成后显示并添加手势
                KingfisherManager.shared.cache.retrieveImage(forKey: photo.q_pic_url, options: [.targetCache(KingfisherManager.shared.cache)]) { (image, type) in
                    var smallImage = image
                    if smallImage == nil {
                        smallImage = UIImage(named: "empty_picture")
                        
                    }
                    self.imageView?.image = smallImage
                    self.imageView?.frame = ls_calculateFrameWithImage(image!)
                    self.imageView?.center = (self.scrollView?.center)!
                    
                    
                    // 4.加载大图图片
                    let url = URL(string: photo.z_pic_url)
                    /// KingfisherOptionsInfoItem.transition(ImageTransition.fade(0.3)) 使图片渐渐显示
                    self.imageView?.kf.setImage(with: ImageResource.init(downloadURL: url!), placeholder: smallImage, options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(0.3)),.targetCache(KingfisherManager.shared.cache)], progressBlock: nil, completionHandler: { (image, error, type, url) in
                        if image != nil {
                            self.scrollView?.isUserInteractionEnabled = true
                            self.imageView?.frame = ls_calculateFrameWithImage(image!)
                            self.imageView?.center = (self.scrollView?.center)!
                        }
                    })
                }
            }else {
                ///本地图片
                
                self.imageView?.image = UIImage(named: photo.z_pic_url)
                self.imageView?.frame = ls_calculateFrameWithImage((self.imageView?.image)!)
                self.imageView?.center = (self.scrollView?.center)!
            }
        }
    }
    

    // MARK: - Private property
    
    
     
    
    fileprivate var scale: CGFloat = 1.0 // 当前的缩放比例
    fileprivate var touchX: CGFloat = 0.0 // 双击点的X坐标
    fileprivate var touchY: CGFloat = 0.0 // 双击点的Y坐标
    
    fileprivate var isDoubleTapingForZoom: Bool = false // 是否是双击缩放
    
    fileprivate var doubleTap : UITapGestureRecognizer? ///双击手势
    fileprivate var singleTap : UITapGestureRecognizer? ///单击手势
    // MARK: - Life cycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        // 初始化View
        self.initAllView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    // MARK: - Private methods
    
    fileprivate func initAllView() {
        // UIScrollView
        self.scrollView = UIScrollView()
        self.scrollView?.showsVerticalScrollIndicator = false
        self.scrollView?.showsHorizontalScrollIndicator = false
        self.scrollView?.maximumZoomScale = maxScale // scrollView最大缩放比例
        self.scrollView?.minimumZoomScale = minScale // scrollView最小缩放比例
        self.scrollView?.backgroundColor = UIColor.clear
        self.scrollView?.delegate = self
        self.scrollView?.frame = self.bounds
        self.scrollView?.center = CGPoint(x:self.center.x,y:self.center.y)
        self.addSubview(self.scrollView!)
        // 添加手势
        // 1.单击手势
        self.singleTap = UITapGestureRecognizer(target: self, action: #selector(LSZoomView.singleTapClick(_:)))
        self.singleTap?.numberOfTapsRequired = 1
        self.scrollView?.addGestureRecognizer(singleTap!)
        // 2.双击手势
        self.doubleTap = UITapGestureRecognizer(target: self, action: #selector(LSZoomView.doubleTapClick(_:)))
        self.doubleTap?.numberOfTapsRequired = 2
        self.scrollView?.addGestureRecognizer(self.doubleTap!)
        // 必须加上这句，否则双击手势不管用
        self.singleTap?.require(toFail: self.doubleTap!)
        
        // UIImageView
        self.imageView = UIImageView()
        self.scrollView?.addSubview(self.imageView!)
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    }



}
// MARK: - UIScrollViewDelegate
extension LSZoomView : UIScrollViewDelegate{
    
    
    open func scrollViewDidZoom(_ scrollView: UIScrollView) {
        //当捏或移动时，需要对center重新定义以达到正确显示位置
        var centerX = scrollView.center.x
        var centerY = scrollView.center.y
        centerX = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width / 2 : centerX
        centerY = scrollView.contentSize.height > scrollView.frame.size.height ?scrollView.contentSize.height / 2 : centerY
        
        self.imageView?.center = CGPoint(x: centerX, y: centerY)
        
        // ****************双击放大图片关键代码*******************
        
        if isDoubleTapingForZoom {
            let contentOffset = self.scrollView?.contentOffset
            let center = self.center
            let offsetX = center.x - self.touchX
            //            let offsetY = center.y - self.touchY
            self.scrollView?.contentOffset = CGPoint(x: (contentOffset?.x)! - offsetX * 2.2, y: (contentOffset?.y)!)
        }
        
        // ****************************************************
        
    }
    
    open func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self.scale = scale
    }
    
    open func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView!
    }

}

// MARK: - 手势处理
extension LSZoomView{
    // 单击手势事件
    @objc func singleTapClick(_ tap: UITapGestureRecognizer) {
        self.zoomDelegate?.ls_tapClick()
    }
    // 双击手势事件
    @objc func doubleTapClick(_ tap: UITapGestureRecognizer) {
        self.touchX = tap.location(in: tap.view).x
        self.touchY = tap.location(in: tap.view).y
        
        if self.scale > 1.0 {
            self.scale = 1.0
            self.scrollView?.setZoomScale(self.scale, animated: true)
        } else {
            self.scale = maxScale
            self.isDoubleTapingForZoom = true
            self.scrollView?.setZoomScale(maxScale, animated: true)
        }
        self.isDoubleTapingForZoom = false
        
    }
    /// 回到初始位置
    func backScale() {
        if self.scale > 1.0 {
            self.scale = 1.0
            self.scrollView?.setZoomScale(self.scale, animated: true)
        }
        
    }
}
