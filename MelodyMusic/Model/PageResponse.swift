//
//  PageResponse.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/24/23.
//

import Foundation
import HandyJSON

class PageResponse:HandyJSON {
    var total:Int = 0
    var pages:Int = 0
    var data:[Sheet]!
    
    required init() {}
}
