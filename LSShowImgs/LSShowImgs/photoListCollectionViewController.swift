//
//  photoListCollectionViewController.swift
//  LSShowImgs
//
//  Created by John_LS on 2016/12/26.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "photoCell"
class photoListCollectionViewController: UICollectionViewController {
    fileprivate lazy var animation :LSAnimationManage = LSAnimationManage()
    
    fileprivate lazy var photos :[LSPhotoItem] = [LSPhotoItem]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView?.register(photoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        // Swift中通过代码注册cell,Class变为self
        self.collectionView?.backgroundColor = UIColor.white
        
        self.loadData(0)

        // Do any additional setup after loading the view.
    }
    func loadData(_ offset : Int){
        // 创建请求管理者
        let urlString = "http://diandianjilin.duapp.com/interface/cheap/product.php"
        LSAlamofire.tools.ls_request(url: urlString, parameters: nil, success: { (data) in
            print("======="+"\(data)")
            self.photos = data!
            self.collectionView?.reloadData()
        }) { (error) in
            print("\(error)")
        }
        
        
        
//        for i in 0..<28 {
//            let item : LSPhotoItem = LSPhotoItem()
//            item.q_pic_url = "\(i%14)"+".jpg"
//            item.z_pic_url = "\(i%14)"+".jpg"
//            item.isUrl = true
//            self.photos.append(item)
//        }
//        // 刷新表格
//        self.collectionView?.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    
        // Configure the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)as!photoCollectionViewCell
        // 传入模型
        cell.photo = self.photos[indexPath.row]
        cell.imgV.frame = CGRect(x:0,y:0,width:cell.frame.width,height:cell.frame.height)
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    // MARK:- UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.animation.ls_showImgs(imgs: photos, index: indexPath, isUrl: false, formVC: self, delegate: self as! LSAnimationStartDelegate)
        animation.indexPath = indexPath
        animation.isUrls = false
        
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
        
    }
}
// MARK:- 动画弹出协议-实现代理方法
extension photoListCollectionViewController :LSAnimationStartDelegate {
    func ls_getStartFrame(_ indexPath: IndexPath) -> CGRect {
        // 获取选中的cell
        guard let cell = collectionView?.cellForItem(at: indexPath) else{
            return CGRect.zero
        }
        // 设置cell的弹出位置的frame
        let startFrame = cell.frame
        // 转换坐标系
        let startRect = collectionView?.convert(startFrame, to: UIApplication.shared.keyWindow!)
        return startRect!
    }
    func ls_getEndFrame(_ indexPath: IndexPath) -> CGRect {
        guard let endCell = collectionView?.cellForItem(at: indexPath) as?photoCollectionViewCell else{
            return CGRect.zero
        }
        // 获取图片
        guard let endImage = endCell.imgV.image else{
            return CGRect.zero
        }
        
        // 获取放大后的frame
        return ls_calculateFrameWithImage(endImage)
    }
    
    func ls_getStartImageView(_ indexPath: IndexPath) -> UIImageView {
        // 创建imageVIew
        let imageV = UIImageView()
        // 获取cell
        guard let imageCell = collectionView?.cellForItem(at: indexPath)as? photoCollectionViewCell else{
            return imageV
        }
        // 获取图片
        guard let imageEnd = imageCell.imgV.image else{
            return imageV
        }
        imageV.image = imageEnd
        imageV.contentMode = .scaleAspectFill
        imageV.clipsToBounds = true
        return imageV

    }
}



