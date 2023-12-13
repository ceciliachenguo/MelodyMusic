//
//  MusicListManager.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 12/12/23.
//
import Foundation

class MusicListManager {
    private static var instance:MusicListManager?
    
    var data:Song?
    
    var datum:[Song] = []
    
    var musicPlayerManager:MusicPlayerManager!
    
    var isPlay = false
    
    static func shared() -> MusicListManager {
        if instance == nil {
            instance = MusicListManager()
        }
        
        return instance!
    }
    
    private init() {
        //初始化音乐播放管理器
        musicPlayerManager = MusicPlayerManager.shared()
    }
    
    /// 设置音乐列表
    func setDatum(_ datum:[Song]) {
        //清空原来的数据
        self.datum.removeAll()
        
        //添加新的数据
        self.datum += datum
    }
    
    /// 播放
    func play(_ data:Song) {
        self.data = data
        
        //标记为播放了
        isPlay = true
        
        let path = data.uri.absoluteURL()
        musicPlayerManager.play(uri: path, data: data)
    }
    
    func pause() {
        musicPlayerManager.pause()
    }
    
    func resume() {
        if isPlay {
            //原来已经播放过
            //也就说播放器已经初始化了
            musicPlayerManager.resume()
        } else {
            //到这里，是应用开启后，第一次点继续播放
            //而这时内部其实还没有准备播放，所以应该调用播放
            play(data!)
        }
    }
}
