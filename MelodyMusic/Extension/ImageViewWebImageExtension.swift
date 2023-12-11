//
//  ImageViewWebImageExtension.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 12/11/23.
//

import Foundation

extension UIImageView{
    /// 显示头像
    func showAvatar2(_ data:String?) {
        show(data, "DefaultAvatar")
    }
    
    /// 显示网络图片
    func show2(_ data: String?, _ defaultImage: String = "Placeholder") {
        if (SuperStringUtil.isBlank(data)) {
            //空

            //显示默认图片
            self.image = UIImage(named: defaultImage)
        } else {
            var newData:String!
            if data!.starts(with: "http") {
                newData = data
            }else{
                newData = data!.absoluteURL()
            }
            
            showFull2(newData)
        }
    }
    
    func showFull2(_ data:String) {
        sd_setImage(with: URL(string: data))
    }
    
}
