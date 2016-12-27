//
//  LSPhotoController.swift
//  LSShowImgs
//
//  Created by John_LS on 2016/12/26.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit
private let ID :String = "photoCellID"


class LSPhotoController: UIViewController {
    fileprivate lazy var collectionView :UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: LSPhotoFlowLayout())
    var phoths : [LSPhotoItem]?
    var indexPath : IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 设置图片浏览分页间距
        view.frame.size.width += spacing
        self.view.backgroundColor = UIColor.purple
        self.setUpUI()
        // 设置选中的图片
        collectionView.scrollToItem(at: indexPath!, at: .left, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
// Mark:- 设置UI
extension LSPhotoController{
    func setUpUI() {
        self.setUpCollectionView()
        self.setUpBtn()
    }
    // 创建CollectionView
    func setUpCollectionView(){
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.bounces = true
        collectionView.register(LSPhotoCell.self, forCellWithReuseIdentifier: ID)
        collectionView.frame = view.bounds
        self.view.addSubview(collectionView)
    }
    
    func setUpBtn(){
        let btn : UIButton = UIButton(type: .custom)
        btn.setTitle("关 闭", for: UIControlState())
        btn.backgroundColor = UIColor.orange
        let margin : CGFloat = 10
        let btnX :CGFloat = 10
        let btnH :CGFloat = 30
        let btnW :CGFloat = 90
        let btnY = UIScreen.main.bounds.height - btnH - margin
        btn.frame = CGRect(x: btnX,y: btnY, width: btnW, height: btnH)
        btn.addTarget(self, action:#selector(LSPhotoController.btnClick), for: .touchUpInside)
        self.view.addSubview(btn)
        
        let saveBtn : UIButton = UIButton(type: .custom)
        saveBtn.setTitle("保 存", for: UIControlState())
        saveBtn.backgroundColor = UIColor.red
        let saveBtnX = UIScreen.main.bounds.width - btnW - margin
        let saveBtnY = btnY
        saveBtn.frame = CGRect(x: saveBtnX, y: saveBtnY, width: btnW, height: btnH)
        
        saveBtn.addTarget(self, action: #selector(LSPhotoController.saveClick), for: .touchUpInside)
        self.view.addSubview(saveBtn)
        
    }
    
    @objc fileprivate func btnClick(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func saveClick(){
        // 1.获取当前正在显示的cell
        let cell = collectionView.visibleCells[0] as! LSPhotoCell
        // 拿到cell显示的图片
        guard let image = cell.zoomView?.imageView?.image else{
            return
        }
        // 2.保存到系统相册
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
}
// MARK:- UICollectionViewDataSource方法
extension LSPhotoController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // ?? : 系统先判断前面的可选链是否有值, 如果有值,解包并且获取对应的类型. 如果没有值直接取后面的值
        return phoths?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as! LSPhotoCell
        let photo = phoths![indexPath.item]
        cell.photo = photo
        cell.zoomView?.zoomDelegate = self
        // cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.blueColor():UIColor.greenColor()
        return cell
        
    }
    
    
}

extension LSPhotoController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        btnClick()
    }
    

    /// cell消失时将图片回复初始比例
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
        guard let cell = collectionView.cellForItem(at: indexPath)  else {
            return
        }
        let cell1 = cell as! LSPhotoCell
        cell1.zoomView?.backScale()
    }
    
}
// MARK: - 动画结束delegate
extension LSPhotoController : LSAnimationEndDelegate {
    /// 获取当前浏览的图片截图（动画利用截图实现）
    ///
    /// - Returns: 当前浏览的图片截图
    internal func ls_getEndImageView() -> UIImageView {
        // 1.创建UIImageView
        let imageView = UIImageView()
        // 2.设置imageView属性
        // 获取屏幕显示的cell
        let cell = collectionView.visibleCells[0] as! LSPhotoCell
        imageView.image = cell.zoomView?.imageView?.image
        imageView.frame = ls_calculateFrameWithImage(imageView.image!)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }

    /// 获取当前浏览的下标
    ///
    /// - Returns: 当前浏览的下标
    internal func ls_getCurrentIndexPath() -> IndexPath {
        // 获取屏幕显示的cell
        let currentCell = collectionView.visibleCells[0]
        // 获取当前屏幕显示的cell的indexpath
        let indexPh = collectionView.indexPath(for: currentCell)!
        
        return indexPh
    }
}

// MARK: - LSZoomDelegate
extension LSPhotoController : LSZoomDelegate{
    func ls_tapClick() {
        btnClick()
    }
}
