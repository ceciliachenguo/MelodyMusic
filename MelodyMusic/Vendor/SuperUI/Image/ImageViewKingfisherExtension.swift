//
//  ImageViewKingfisherExtension.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 8/14/23.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func showAvatar(_ data: String?){
        show(data, "DefaultAvatar")
    }
    
    func show(_ data:String?,_ defaultImage:String="Placeholder") {
        if SuperStringUtil.isBlank(data) {
            image = UIImage(named: defaultImage)
        } else {
            var newData:String!
            if data!.starts(with: "http"){
                newData = data
            } else {
                newData = data?.absoluteURL()
            }
            showFull(newData)
        }
    }
    
    func showFull(_ data:String) {
        kf.indicatorType = .activity
        kf.setImage(with: URL(string: data))
    }
}
