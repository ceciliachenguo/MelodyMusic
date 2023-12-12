//
//  SimplePlayerController.swift
//  a simple music player, for test uses.
//
//  Created by Cecilia Chen on 12/11/23.
//

import UIKit
import TangramKit

class SimplePlayerController: BaseTitleController {
//    private var lyricView:LyricListView!
    var startView:UILabel!
    var progressView:UISlider!
    var endView:UILabel!
    var playButtonView:QMUIButton!
    var loopModelButtonView:QMUIButton!
    
    /// 是否按下了进度条
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
    }
    
    @objc func onPreviousClick(_ sender:QMUIButton) {
    }
    
    @objc func onPlayClick(_ sender:QMUIButton) {
    }
    
    @objc func onNextClick(_ sender:QMUIButton) {
        
    }
    
    @objc func onLoopModelClick(_ sender:QMUIButton) {
        
    }

    static func orientationContainer(_ orientation:TGOrientation = .horz) -> TGLinearLayout {
        let result = TGLinearLayout(orientation)
        result.tg_width.equal(.fill)
        result.tg_height.equal(.wrap)
        
        return result
    }
    
}
