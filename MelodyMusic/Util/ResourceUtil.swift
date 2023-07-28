//
//  ResourceUtil.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/28/23.
//

import Foundation

class ResourceUtil {
    //Convert into absolute path
    static func resourceUrl(_ data: String) -> String {
        return "\(Config.RESOURCE_ENDPOINT)/\(data)"
    }
}
