//
//  SuperFileUtil.swift
//  file system tool
//
//  Created by Cecilia Chen on 12/10/23.
//

import Foundation

class SuperFileUtil {
    /// 是否存在，文件夹，文件都可以判断
    static func exists(_ data:String) -> Bool {
        let manager=FileManager.default
        return manager.fileExists(atPath: data)
    }
    
    /// 创建文件夹
    static func mkdirs(_ data:String) {
        let manager=FileManager.default
        try! manager.createDirectory(atPath: data, withIntermediateDirectories: true)
    }
    
    /// 文件大小格式化
    static func formatFileSize(_ data:Int) -> String {
        if data > 0{
            let size=Double(data)
            
            let kiloByte=size/1024
            if kiloByte < 1 && kiloByte > 0 {
                //不足1K
                return String(format: "%.2fByte", size)
            }
            
            let megaByte = kiloByte / 1024
            if megaByte < 1 {
                //不足1M
                return String(format: "%.2fK", kiloByte)
            }
            
            let gigaByte = megaByte / 1024
            if gigaByte < 1 {
                //不足1G
                return String(format: "%.2fM", megaByte)
            }
            
            let teraByte = gigaByte / 1024
            if teraByte < 1 {
                //不足1T
                return String(format: "%.2fG", gigaByte)
            }
            
            return String(format: "%.2fT", teraByte)
        }
        
        return "0K"
        
    }
}
