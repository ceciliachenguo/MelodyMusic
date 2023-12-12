//
//  MusicPlayerManager.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 12/11/23.
//

import Foundation

class MusicPlayerManager {
    private static var instance:MusicPlayerManager?
    
    /// 当前播放的音乐
    var data:Song?
    
    /// 播放器
    private var player:AVPlayer!
    
    var status:PlayStatus = .none
        
    /// 获取单例的播放管理器
    static func shared() -> MusicPlayerManager {
        if instance == nil {
            instance = MusicPlayerManager()
        }
        
        return instance!
    }
    
    private init() {
        player = AVPlayer()
    }
    
    /// 播放
    func play(uri:String, data:Song) {
        status = .playing
        self.data = data
                
        var url:URL?=nil
        if uri.starts(with: "http") {
            url = URL(string: uri)
        } else {
            url = URL(fileURLWithPath: uri)
        }
        
        let item = AVPlayerItem(url: url!)
        
        //替换掉原来的播放Item
        player.replaceCurrentItem(with: item)
        
        player.play()
    }
    
    /// 暂停
    func pause() {
        status = .pause
        player.pause()
        
    }
    
    /// 继续播放
    func resume() {
        status = .playing
        player.play()
    }
    
    func isPlaying() -> Bool {
        return status == .playing
    }
}


enum PlayStatus {
    case none
    case pause
    case playing
    case prepared
    case completion
    case error
}
