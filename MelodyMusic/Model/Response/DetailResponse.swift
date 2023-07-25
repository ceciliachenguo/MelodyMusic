//
//  DetailResponse.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/25/23.
//

import Foundation
import HandyJSON

class DetailResponse<T:HandyJSON>: BaseResponse {
    var data:T?
    
    init(data: T? = nil) {
        self.data = data
    }
    
    required init() {}
}
