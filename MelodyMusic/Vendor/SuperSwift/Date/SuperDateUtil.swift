//
//  SuperDateUtil.swift
//  Class for Date
//
//  Created by Cecilia Chen on 7/22/23.
//

import Foundation

class SuperDateUtil {
    
    static func currentYear() -> Int {
        let date = Date()
        
        let calendar = Calendar.current
        let d = calendar.dateComponents([Calendar.Component.year], from: date)
        
        return d.year!
    }
}
