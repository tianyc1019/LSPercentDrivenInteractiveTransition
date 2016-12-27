//
//  LSPhotoCell.swift
//  LSShowImgs
//
//  Created by John_LS on 2016/12/26.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit
import Kingfisher
///图片间距
let spacing : CGFloat = 10.0
class LSPhotoCell: UICollectionViewCell {
    
    /// 图片控制
    var zoomView: LSZoomView?
    // MARK:-重写模型属性的set方法
    var photo :LSPhotoItem? {
        didSet{
            // print(shop?.z_pic_url)
            // 1.校验shop是否有值
            guard let photo = photo else{
                return
            }
            zoomView?.photo = photo
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
        // 图片添加到cell的zoomView上
        if zoomView == nil {
//            let frame = UIScreen.main.bounds
            zoomView = LSZoomView(frame:CGRect(x:0,y:0,width:self.frame.width-spacing,height:self.frame.height) )
            self.addSubview(zoomView!)
        }
    }
}
