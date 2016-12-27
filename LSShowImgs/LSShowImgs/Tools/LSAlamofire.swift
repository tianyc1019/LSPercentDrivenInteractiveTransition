//
//  LSAlamofire.swift
//  LSShowImgs
//
//  Created by John_LS on 2016/12/27.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class LSAlamofire: NSObject {
    // 创建单例
    static let tools : LSAlamofire = {
        let netTool = LSAlamofire()
        return netTool
    }()

    
}
extension LSAlamofire{
    func ls_request(url : String? ,parameters: Parameters? ,success:@escaping (_ result : [LSPhotoItem]?)->(),failure:@escaping (_ error : AnyObject?)->()) {
        Alamofire.request(url!, parameters: parameters).responseJSON{ response in
            switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let goods = json["data"]["hot_sale"].array
                    var array : [LSPhotoItem] = [LSPhotoItem]()
                    for good in goods! {
                        //Do something you want
                        let item = LSPhotoItem()
                        item.isUrl = true
                        item.q_pic_url = good["thumbnail_img"].string!
                        item.z_pic_url = good["thumbnail_img"].string!
                        array.append(item)
                    }
                
                    success(array)
                case .failure(let error):
                    print(error)
            }
        }

    }
}
