//
//  Ad.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/25/23.
//

import Foundation

class Ad: BaseCommon {
    var title:String!
    var icon:String!
    var uri:String!
    
    /// 类型，0：图片；10：视频；20：应用
    var style: Int = 0
}
