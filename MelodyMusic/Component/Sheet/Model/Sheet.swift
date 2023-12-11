//
//  Sheet.swift
//  Sheet Model
//
//  Created by Cecilia Chen on 7/24/23.
//

import Foundation
import HandyJSON

class Sheet:BaseCommon {
    var title:String!
    var icon:String?
    
    var clicksCount:Int=0
    var collectsCount:Int=0
    var commentsCount:Int=0
    var songsCount:Int=0

    var user:User!

    var songs:Array<Song>?
    
    var detail:String?
    
    override func mapping(mapper: HelpingMapper) {
        super.mapping(mapper: mapper)
        mapper <<< self.clicksCount <-- "clicks_count"
        mapper <<< self.collectsCount <-- "collects_count"
        mapper <<< self.commentsCount <-- "comments_ount"
        mapper <<< self.songsCount <-- "songs_count"
    }
}
