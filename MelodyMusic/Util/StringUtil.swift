//
//  StringUtil.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 9/6/23.
//

import Foundation

class StringUtil {
    
    /// 是否符合密码格式
    /// - Parameter data: 要判断的值
    /// - Returns: true：符合;false：不符合
    static func isPassword(_ data:String) -> Bool {
        return data.count >= 6 && data.count<=15
    }
    
    /// 是否符合昵称格式
    static func isNickname(_ data:String) -> Bool {
        return data.count >= 2 && data.count<=10
    }
    
    /// 格式化数量
    static func formatCount(_ data:Int) -> String  {
        if data > 99 {
            return "99+"
        }
        
        return "\(data)"
    }
}
