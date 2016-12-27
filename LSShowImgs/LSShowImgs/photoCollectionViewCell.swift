//
//  photoCollectionViewCell.swift
//  LSShowImgs
//
//  Created by John_LS on 2016/12/26.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit
import Kingfisher
class photoCollectionViewCell: UICollectionViewCell {
    
    
    var imgV: UIImageView! = UIImageView.init()
    var photo : LSPhotoItem? {
        didSet{
            guard let photo = photo else{
                return
            }
//            let url = URL(string: photo.q_pic_url)
            self.addSubview(self.imgV)
            self.imgV.image = UIImage.init(named: photo.q_pic_url)
            self.imgV.contentMode = UIViewContentMode.scaleAspectFit
//            self.photoImgV.kf.setImage(with: ImageResource.init(downloadURL: url!), placeholder:  UIImage.init(named: "empty_picture"), options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(0.3)),.targetCache(KingfisherManager.shared.cache)], progressBlock: nil, completionHandler: nil)
        }
    }
    
    
}
