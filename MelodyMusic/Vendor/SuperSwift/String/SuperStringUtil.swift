//
//  SuperStringUtil.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 8/14/23.
//

import Foundation
import SwifterSwift

class SuperStringUtil {
    
    static func isNotBlank(_ data:String?) -> Bool {
        return !isBlank(data)
    }
    
    static func isBlank(_ data:String?) -> Bool {
        var data = data
        data = data?.trimmed
        return data == nil || data!.isEmpty
    }
}
