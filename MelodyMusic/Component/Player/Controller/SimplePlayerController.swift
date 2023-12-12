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
        
        MusicPlayerManager.shared()
            .play(uri: "http://srm.net/mp3/srm_buss_ii.mp3", data: Song())
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
        showMusicPlayStatus()
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

    }
    
    func onPaused(data: Song) {
        showPlayStatus()
    }
    
    func onPlaying(data: Song) {
        showPauseStatus()
    }
    
    func onProgress(data: Song) {
        
    }
    
    func onLyricReady(data: Song) {

    }
    
    func onError(data: Song) {
        
    }
}
