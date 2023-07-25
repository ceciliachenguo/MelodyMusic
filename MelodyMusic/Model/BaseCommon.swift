//
//  BaseCommon.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/25/23.
//

import UIKit
import HandyJSON

class BaseCommon: BaseId {
    var createdAt:String!
    var updatedAt:String!
    
    override func mapping(mapper: HelpingMapper) {
        super.mapping(mapper: mapper)
        mapper <<< self.createdAt <-- "created_at"
        mapper <<< self.updatedAt <-- "updated_at"
    }
}
