//
//  Meta.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/25/23.
//

import Foundation
import HandyJSON

class Meta<T:HandyJSON>: BaseModel {
    
    var data:[T]?
    var total:Int!
    //total num of pages
    var pages:Int!
    var size:Int!
    //current page num
    var page:Int!
    var next:Int?
}
