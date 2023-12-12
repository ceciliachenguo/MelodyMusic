//
//  Song.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 8/14/23.
//

import Foundation
import HandyJSON

class Song: BaseCommon {
    static let NAME = "Song"
    
    var title:String!
    var icon:String?
    var url:String!
    
    var clicksCount:Int = 0
    var commentsCount:Int = 0
    
    var user:User!
    var singer:User!
    
    var style:Int = 0
    
    var lyric:String? = nil
    
    //in seconds
    var duration:Float = 0
    
    var progress:Float = 0

    override func mapping(mapper: HelpingMapper) {
        super.mapping(mapper: mapper)
        mapper <<< self.clicksCount <-- "clicks_count"
        mapper <<< self.commentsCount <-- "comments_count"
    }
    
}
