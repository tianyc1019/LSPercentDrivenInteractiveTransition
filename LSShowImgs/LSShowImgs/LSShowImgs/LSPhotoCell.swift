//
//  LSPhotoCell.swift
//  LSShowImgs
//
//  Created by John_LS on 2016/12/26.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit
import Kingfisher
class LSPhotoCell: UICollectionViewCell {
    // MARK:- 懒加载控件
    lazy var imageV :UIImageView = UIImageView()
    // MARK:-重写模型属性的set方法
    var photo :LSPhotoItem? {
        didSet{
            // print(shop?.z_pic_url)
            // 1.校验shop是否有值
            guard let photo = photo else{
                return
            }
            // 2.获取小图片
            if photo.isUrl! {
                ///通过连接加载图片
                KingfisherManager.shared.cache.retrieveImage(forKey: photo.q_pic_url, options: [.targetCache(KingfisherManager.shared.cache)]) { (image, type) in
                    var smallImage = image
                    if smallImage == nil {
                        smallImage = UIImage(named: "empty_picture")
                    }
                    // 3.根据image计算出来放大之后的frame
                    self.imageV.frame = ls_calculateFrameWithImage(smallImage!)
                    // 4.设置图片
                    let url = URL(string: photo.z_pic_url)
                    /// KingfisherOptionsInfoItem.transition(ImageTransition.fade(0.3)) 使图片渐渐显示
                    self.imageV.kf.setImage(with: ImageResource.init(downloadURL: url!), placeholder: smallImage, options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(0.3)),.targetCache(KingfisherManager.shared.cache)], progressBlock: nil, completionHandler: { (image, error, type, url) in
                        self.imageV.frame = ls_calculateFrameWithImage(image!)
                        self.imageV.contentMode = UIViewContentMode.scaleAspectFit
                    })
                }
            }else{
                imageV.image = UIImage.init(named: photo.z_pic_url)
                self.imageV.frame = ls_calculateFrameWithImage(imageV.image!)
                self.imageV.contentMode = UIViewContentMode.scaleAspectFit
            }
            
        }
    }
    // MARK:- 重写init初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    // required : 如果一个构造函数前有required,那么重写了其他构造函数时,那么该构造函数也必须被重写
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
// MARK:-设置UI
extension LSPhotoCell{
    func setUpUI(){
        // 图片添加到cell的contentView上
        self.contentView.addSubview(imageV)
    }
}
