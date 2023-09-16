//
//  StringUtil.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 9/6/23.
//

import Foundation

class StringUtil {
    
    static func isPassword(_ data:String) -> Bool {
        return data.count >= 6 && data.count<=15
    }
    
    static func isNickname(_ data:String) -> Bool {
        return data.count >= 2 && data.count<=10
    }
    
    static func formatCount(_ data:Int) -> String  {
        if data > 99 {
            return "99+"
        }
        
        return "\(data)"
    }
}
