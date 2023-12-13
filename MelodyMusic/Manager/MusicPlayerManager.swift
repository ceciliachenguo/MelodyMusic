//
//  MusicPlayerManager.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 12/11/23.
//

import Foundation

class MusicPlayerManager: NSObject {
    private static var instance:MusicPlayerManager?
    
    private var data:Song?
    
    private var player:AVPlayer!
    
    var status:PlayStatus = .none
    
    /// 代理对象，目的是将不同的状态分发出去
    weak open var delegate:MusicPlayerManagerDelegate?{
        didSet{
            if let _ = self.delegate {
                if self.isPlaying() {
                    startPublishProgress()
                }
            }else {
                pause()
                stopPublishProgress()
            }
        }
    }
    
    var playTimeObserve: Any?
        
    /// 获取单例的播放管理器
    static func shared() -> MusicPlayerManager {
        if instance == nil {
            instance = MusicPlayerManager()
        }
        
        return instance!
    }
    
    private override init() {
        super.init()
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
        
        if let r = delegate {
            r.onPlaying(data: data)
        }
        
        initListeners()
        
        startPublishProgress()
    }
    
    /// 暂停
    func pause() {
        status = .pause
        player.pause()
        
        if let r = delegate {
            r.onPaused(data: data!)
        }
        
        removeListeners()
        
        stopPublishProgress()
    }
    
    /// 继续播放
    func resume() {
        status = .playing
        player.play()
        
        if let r = delegate {
            r.onPlaying(data: data!)
        }
        
        initListeners()
        
        startPublishProgress()
    }
    
    func isPlaying() -> Bool {
        return status == .playing
    }
    
    func seekTo(_ data:Float)  {
        let positionTime = CMTime(seconds: Double(data), preferredTimescale: 1)
        player.seek(to: positionTime)
    }
    
    func initListeners() {
        //KVO方式监听播放状态
        //KVC:Key-Value Coding,另一种获取对象字段的值，类似字典
        //KVO:Key-Value Observing,建立在KVC基础上，能够观察一个字段值的改变
        player.currentItem?.addObserver(self, forKeyPath: MusicPlayerManager.STATUS, options: .new, context: nil)
        
        //监听音乐缓冲状态
        player.currentItem?.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        
        //播放结束事件
        NotificationCenter.default.addObserver(self, selector: #selector(onComplete(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }
    
    private func removeListeners() {
        player.currentItem?.removeObserver(self, forKeyPath: MusicPlayerManager.STATUS)
        player.currentItem?.removeObserver(self, forKeyPath: "loadedTimeRanges")
    }
    
    @objc func onComplete(_ sender:Notification) {

    }
    
    /// KVO监听回调方法
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if MusicPlayerManager.STATUS == keyPath {
            switch player.status {
            case .readyToPlay:
                self.data!.duration = Float(CMTimeGetSeconds(player.currentItem!.asset.duration))
                
                delegate?.onPrepared(data:data!)
                
            case .failed:
                status = .error
                
                delegate?.onError(data: data!)
            default:
                status = .none
            }
        }
    }
    
    func startPublishProgress() {
        if let _ = playTimeObserve {
            return
        }
        
        //1/60 seconds
        playTimeObserve = player.addPeriodicTimeObserver(forInterval: CMTime(value: CMTimeValue(1.0), timescale: 60), queue: DispatchQueue.main, using: { time in
            self.data!.progress = Float(CMTimeGetSeconds(time))
                        
            guard let delegate = self.delegate else {
                self.stopPublishProgress()
                return
            }
            
            delegate.onProgress(data: self.data!)
        })
    }
    
    func stopPublishProgress() {
        if let playTimeObserve = playTimeObserve {
            player.removeTimeObserver(playTimeObserve)
            self.playTimeObserve = nil
        }
    }
    
    static let STATUS = "status"
}


enum PlayStatus {
    case none
    case pause
    case playing
    case prepared
    case completion
    case error
}

protocol MusicPlayerManagerDelegate:NSObjectProtocol {
    func onPrepared(data:Song)
    
    func onPaused(data:Song)
    
    func onPlaying(data:Song)
    
    func onProgress(data:Song)
    
    func onLyricReady(data:Song)
    
    func onError(data:Song)
}

