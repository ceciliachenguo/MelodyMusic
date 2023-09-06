//
//  User.swift
//  User Model
//
//  Created by Cecilia Chen on 7/24/23.
//

import Foundation
import HandyJSON

class User: BaseCommon {
    /// 昵称
    var nickname:String!

    /// 头像
    var icon:String!
    
    /// 手机号
    var phone:String!
    
    /// 邮箱
    var email:String!

    /// 用户的密码,登录，注册向服务端传递
    var password:String!

    /// 微信第三方登录后id
    var wechatId:String!

    /// QQ第三方登录后Id
    var qqId:String!

    /// 苹果第三方登录后Id
    var appleId:String!

    /// 验证码
    /// 只有找回密码的时候才会用到
    var code:String!
    
    /// 省
    var province:String!

    /// 省编码
    var provinceCode:String!

    /// 市
    var city:String!

    /// 市编码
    var cityCode:String!

    /// 区
    var area:String!

    /// 区编码
    var areaCode:String!
    
    /// 我的关注的人（好友）
    var followingsCount:Int!

    /// 关注我的人（粉丝）
    var followersCount:Int!

    /// 是否关注
    /// 1:关注
    /// 在用户详情才会返回
    var following:String!
    
    /// 性别
    /// 0：保密，10：男，20：女
    /// 可以定义为枚举
    /// 但枚举性能没有int好
    /// 但int没有一些编译验证
    /// Android中有替代方式
    /// 这里用不到就不讲解了
    var gender:Int!

    /// 生日
    /// 格式为：yyyy-MM-dd
    var birthday:String!

    /// 设备名称
    /// 例如：小米11
    var device:String!

    /// 推送id
    var push:String!

    /// 平台
    /// 主要是实现同一个平台只能登录一个账号
    var platform:Int! = 10

    /// 直播间id
    var roomId:String!

    /// 角色字符串，逗号分割
    var roles:String!
    
    /// 个人描述
    var detail:String?

    //本地过滤字段
    /// 拼音
    var pinyin:String!

    /// 拼音首字母
    var pinyinFirst:String!

    /// 拼音首字母的首字母
    var first:String!
    //end 本地过滤字段

    /// 是否关注了
    func isFollowing() -> Bool {
        return following != nil
    }
    
    override func mapping(mapper: HelpingMapper) {
        super.mapping(mapper: mapper)
        mapper <<< self.wechatId <-- "wechat_id"
        mapper <<< self.qqId <-- "qq_id"
        mapper <<< self.appleId <-- "apple_id"
        mapper <<< self.provinceCode <-- "province_code"
        mapper <<< self.cityCode <-- "city_code"
        mapper <<< self.areaCode <-- "area_code"
        mapper <<< self.followingsCount <-- "followings_count"
        mapper <<< self.followersCount <-- "followers_count"
        mapper <<< self.roomId <-- "room_id"
    }
}
