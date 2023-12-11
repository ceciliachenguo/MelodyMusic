//
//  StorageUtil.swift
//  storage related
//
//  Created by Cecilia Chen on 12/10/23.
//

import Foundation

class StorageUtil {
    static func adPath(_ data:String) -> URL {
        //应用的/Documents/
        let documentPath =  NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
        
        return URL(fileURLWithPath: documentPath).appendingPathComponent("ads/").appendingPathComponent(data)
    }
}
