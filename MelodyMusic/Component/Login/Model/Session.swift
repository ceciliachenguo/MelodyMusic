//
//  Session.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 9/6/23.
//

import UIKit

//导入JSON解析框架
import HandyJSON

class Session: BaseModel {
    /// 用户Id
    var userId:String!
    
    /// 登录后的Session
    var session:String!
    
    /// 聊天token
    var chatToken:String!

    override func mapping(mapper: HelpingMapper) {
        super.mapping(mapper: mapper)
        mapper <<< self.userId <-- "user_id"
        mapper <<< self.chatToken <-- "chat_token"
    }
}
