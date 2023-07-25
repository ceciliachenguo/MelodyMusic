//
//  SheetList.swift
//  Music Sheet list
//
//  Created by Cecilia Chen on 7/24/23.
//

import Foundation
import HandyJSON

class SheetListResponse:HandyJSON {
    var status:Int = 0
    var data:PageResponse!
    
    required init() {}
}
