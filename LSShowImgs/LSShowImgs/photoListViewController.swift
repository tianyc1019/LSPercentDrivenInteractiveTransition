//
//  photoListViewController.swift
//  LSShowImgs
//
//  Created by John_LS on 2016/12/26.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit
private let reuseIdentifier = "photoCell"
class photoListViewController: UICollectionViewController {

    fileprivate lazy var animation :LSAnimationManage = LSAnimationManage()
    
    fileprivate lazy var photos :[LSPhotoItem] = [LSPhotoItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Swift中通过代码注册cell,Class变为self
        self.collectionView?.backgroundColor = UIColor.white
        
        self.loadData(0)
    }
    
    func loadData(_ offset : Int){
        
        for i in 0..<20 {
            let dic : [String:Any] = ["q_pic_url":"\(i)"+".jpg","z_pic_url":"\(i)"+".jpg","isUrl":false]
            
            let item : LSPhotoItem = LSPhotoItem.init(dict: dic)
            
            self.photos.append(item)
        }
        // 刷新表格
        self.collectionView?.reloadData()
    }
    // MARK:- UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)as!photoCollectionViewCell
        // 传入模型
        cell.photo = self.photos[indexPath.row]
        // 当最后一个cell显示时上拉加载更多数据
        if indexPath.item == self.photos.count - 1 {
            self.loadData(self.photos.count)
        }
        // print(shop.q_pic_url,shop.z_pic_url)
        
        return cell
    }
    
    // MARK:- UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        animation.ls_showImgs(imgs: photos, index: indexPath, isUrl: false, formVC: self, delegate: self as! LSAnimationStartDelegate)
        
        
    }
    



}
