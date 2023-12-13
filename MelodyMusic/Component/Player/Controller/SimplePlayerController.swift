//
//  SimplePlayerController.swift
//  a simple music player, for test uses.
//
//  Created by Cecilia Chen on 12/11/23.
//

import UIKit
import TangramKit

class SimplePlayerController: BaseTitleController {
    var startView:UILabel!
    var progressView:UISlider!
    var endView:UILabel!
    var playButtonView:QMUIButton!
    var loopModelButtonView:QMUIButton!
    
    var isTouchProgress = false
    
    override func initViews() {
        super.initViews()
        initTableViewSafeArea()
        setBackgroundColor(.colorLightWhite)
        
        //进度容器
        let progressContainer = ViewFactoryUtil.orientationContainer()
        progressContainer.tg_gravity = TGGravity.vert.center
        progressContainer.tg_space = PADDING_MIDDLE
        progressContainer.tg_padding = UIEdgeInsets(top: PADDING_MIDDLE, left: PADDING_OUTER, bottom: PADDING_MIDDLE, right: PADDING_OUTER)
        container.addSubview(progressContainer)
        
        startView = UILabel()
        startView.tg_width.equal(.wrap)
        startView.tg_height.equal(.wrap)
        startView.text = "00:00"
        progressContainer.addSubview(startView)
        
        progressView = UISlider()
        progressView.tg_width.equal(.fill)
        progressView.tg_height.equal(.wrap)
        
        progressView.value = 0
        progressContainer.addSubview(progressView)
        
        endView = UILabel()
        endView.tg_width.equal(.wrap)
        endView.tg_height.equal(.wrap)
        endView.text = "00:00"
        progressContainer.addSubview(endView)
        
        //按钮容器
        let controlContainer = ViewFactoryUtil.orientationContainer()
        controlContainer.tg_gravity = TGGravity.vert.center
        controlContainer.tg_padding = UIEdgeInsets(top: PADDING_MIDDLE, left: PADDING_OUTER, bottom: PADDING_MIDDLE, right: PADDING_OUTER)
        container.addSubview(controlContainer)
        
        var buttonView = QMUIButton()
        buttonView.tg_width.equal(.fill)
        buttonView.tg_height.equal(.wrap)
        buttonView.setTitle("上一曲", for: .normal)
        buttonView.addTarget(self, action: #selector(onPreviousClick(_:)), for: .touchUpInside)
        controlContainer.addSubview(buttonView)
        
        playButtonView = QMUIButton()
        playButtonView.tg_width.equal(.fill)
        playButtonView.tg_height.equal(.wrap)
        playButtonView.setTitle("播放", for: .normal)
        playButtonView.addTarget(self, action:#selector(onPlayClick(_:)), for: .touchUpInside)
        controlContainer.addSubview(playButtonView)
        
        buttonView = QMUIButton()
        buttonView.tg_width.equal(.fill)
        buttonView.tg_height.equal(.wrap)
        buttonView.setTitle("下一曲", for: .normal)
        buttonView.addTarget(self, action: #selector(onNextClick(_:)), for: .touchUpInside)
        controlContainer.addSubview(buttonView)
        
        loopModelButtonView = QMUIButton()
        loopModelButtonView.tg_width.equal(.fill)
        loopModelButtonView.tg_height.equal(.wrap)
        loopModelButtonView.setTitle("列表循环", for: .normal)
        loopModelButtonView.addTarget(self, action:#selector(onLoopModelClick(_:)), for: .touchUpInside)
        controlContainer.addSubview(loopModelButtonView)
        
        let song = Song()
        song.title = "test title music"
        MusicPlayerManager.shared()
            .play(uri: "http://srm.net/mp3/srm_buss_ii.mp3", data: song)
    }
    
    override func initDatum() {
        super.initDatum()
    }
    
    override func initListeners() {
        super.initListeners()
        //监听应用进入前台了
        NotificationCenter.default.addObserver(self, selector: #selector(onEnterForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        //监听应用进入后台了
        NotificationCenter.default.addObserver(self, selector: #selector(onEnterBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
        //进度条拖拽监听
        progressView.addTarget(self, action: #selector(progressChanged(_:)), for: .valueChanged)
        progressView.addTarget(self, action: #selector(progressTouchDown(_:)), for: .touchDown)
        progressView.addTarget(self, action: #selector(progressTouchUp(_:)), for: .touchUpInside)
        progressView.addTarget(self, action: #selector(progressTouchUp(_:)), for: .touchUpOutside)

    }
    
    /// 进度条拖拽回调
    @objc func progressChanged(_ sender:UISlider) {
        //将拖拽进度显示到界面
        //用户就很方便的知道自己拖拽到什么位置
        startView.text = SuperDateUtil.second2MinuteSecond(sender.value)

        //音乐切换到拖拽位置播放
        MusicPlayerManager.shared().seekTo(sender.value)
    }

    /// 进度条按下
    @objc func progressTouchDown(_ sender:UISlider) {
        isTouchProgress=true
    }

    /// 进度条抬起
    @objc func progressTouchUp(_ sender:UISlider) {
        isTouchProgress=false
    }
    
    func setMusicPlayerDelegate() {
        initPlayData()
        MusicPlayerManager.shared().delegate = self
    }
    
    func removeMusicPlayerDelegate() {
        MusicPlayerManager.shared().delegate = nil
    }
    
    @objc func onEnterForeground() {
        initPlayData()
        
        setMusicPlayerDelegate()
    }
    
    /// 进入后台了
    @objc func onEnterBackground() {
        removeMusicPlayerDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setMusicPlayerDelegate()
        
        print("SimplePlayerController viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setMusicPlayerDelegate()
        
        print("SimplePlayerController viewDidAppear")
        
        initPlayData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("SimplePlayerController viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("SimplePlayerController viewDidDisappear")
        removeMusicPlayerDelegate()
    }
    
    @objc func onPreviousClick(_ sender:QMUIButton) {
    }
    
    @objc func onPlayClick(_ sender:QMUIButton) {
        playOrPause()
    }
    
    @objc func onNextClick(_ sender:QMUIButton) {
        
    }
    
    @objc func onLoopModelClick(_ sender:QMUIButton) {
        
    }
    
    func initPlayData() {
        showInitData()
        
        showDuration()

        showProgress()
        
        showMusicPlayStatus()
    }
    
    func showInitData() {
        let data = MusicPlayerManager.shared().data!
        
        title = data.title
    }
    
    func showDuration() {
        let duration = MusicPlayerManager.shared().data!.duration
        if duration > 0 {
            endView.text = SuperDateUtil.second2MinuteSecond(duration)
            progressView.maximumValue = duration
        }
    }
    
    func showProgress() {
        if isTouchProgress {
            return
        }
        
        let progress = MusicPlayerManager.shared().data!.progress
        
        if (progress > 0) {
            startView.text = SuperDateUtil.second2MinuteSecond(progress)
            progressView.value = progress
        }
    }
    
    func showMusicPlayStatus() {
        if MusicPlayerManager.shared().isPlaying() {
            showPauseStatus()
        } else {
            showPlayStatus()
        }
    }
    
    func playOrPause() {
        if MusicPlayerManager.shared().isPlaying() {
            MusicPlayerManager.shared().pause()
        } else {
            MusicPlayerManager.shared().resume()
        }
    }
    
    func showPlayStatus() {
        playButtonView.setTitle("播放", for: .normal)
    }
    
    func showPauseStatus() {
        playButtonView.setTitle("暂停", for: .normal)
    }

    static func orientationContainer(_ orientation:TGOrientation = .horz) -> TGLinearLayout {
        let result = TGLinearLayout(orientation)
        result.tg_width.equal(.fill)
        result.tg_height.equal(.wrap)
        
        return result
    }
}

// MARK: -  播放管理器代理
extension SimplePlayerController:MusicPlayerManagerDelegate{
    func onPrepared(data: Song) {
        showInitData()
        
        showDuration()
    }
    
    func onPaused(data: Song) {
        showPlayStatus()
    }
    
    func onPlaying(data: Song) {
        showPauseStatus()
    }
    
    func onProgress(data: Song) {
        showProgress()
    }
    
    func onLyricReady(data: Song) {

    }
    
    func onError(data: Song) {
        
    }
}
