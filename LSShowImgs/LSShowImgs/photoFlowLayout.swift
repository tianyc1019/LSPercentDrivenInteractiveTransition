//
//  photoFlowLayout.swift
//  LSShowImgs
//
//  Created by John_LS on 2016/12/26.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit

class photoFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        let clos : CGFloat = 3
        let margin : CGFloat = 15
        
        let itemWH = (UIScreen.main.bounds.width - (clos + 1) * margin) / clos
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumLineSpacing = margin
        minimumInteritemSpacing = margin
        
        self.collectionView?.contentInset = UIEdgeInsetsMake(64 + margin, margin, margin, margin)
        
        
        
    }
}
