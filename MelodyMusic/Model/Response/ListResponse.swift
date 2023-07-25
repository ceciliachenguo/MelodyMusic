//
//  ListResponse.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/25/23.
//

import Foundation
import HandyJSON

class ListResponse<T:HandyJSON>: BaseResponse {
    var data:Meta<T>!
}
