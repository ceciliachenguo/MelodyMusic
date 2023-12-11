//
//  AdController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 12/10/23.
//

import Foundation

class AdController: BaseLogicController {
    var data:Ad?
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    override func initViews() {
        super.initViews()
        
        //图片广告
        view.addSubview(iconView)
        
        initRelativeLayoutSafeArea()
        
        //跳过广告按钮
        container.addSubview(skipView)
        
        //提示按钮
        container.addSubview(tipView)
    }
    
    override func initListeners() {
        super.initListeners()
        initTapHideKeyboard()
        
        //监听应用进入前台了
        NotificationCenter.default.addObserver(self, selector: #selector(onEnterForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        //监听应用进入后台了
        NotificationCenter.default.addObserver(self, selector: #selector(onEnterBackground), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    override func tapClick(_ data: UITapGestureRecognizer) {
        tipClick()
    }
    
    override func initDatum() {
        super.initDatum()
        //获取广告信息
        data = PreferenceUtil.getSplashAd()
        if data == nil {
            next()
            return
        }
        
        show()
    }
    
    func next() {
        //取消倒计时
        CountDownUtil.cancel()
        
        AppDelegate.shared.toMain()
    }

    //显示广告信息
    func show() {
        let uri = StorageUtil.adPath(data!.icon)
        if !SuperFileUtil.exists(uri.path) {
            //记录日志，因为正常来说，只要保存了，文件不能丢失
            next()
            return
        }
        
        switch data!.style {
        case VALUE10:
            showVideoAd(uri)
        default:
            showImageAd(uri.path)
        }
    }
    
    func showVideoAd(_ data:URL) {
        //播放应用内嵌入视频，放根目录中
        //同样其他的文件，也可以通过这种方式读取
        //var data=Bundle.main.url(forResource: "ixueaeduTestVideo", withExtension: ".mp4")!
        player = AVPlayer(url: data)
        
        //静音
        player!.isMuted = true
        
        /// 添加进度监听
        player!.addPeriodicTimeObserver(forInterval: CMTime(value: CMTimeValue(1.0), timescale: 60), queue: DispatchQueue.main, using: {time in
            if self.player == nil {
                return
            }
            
            //播放时间
            let current = Float(CMTimeGetSeconds(time))
            
            //总时间
            let duration = Float(CMTimeGetSeconds(self.player!.currentItem!.duration))
            
            if current==duration {
                //视频播放结束
                self.next()
            } else {
                self.skipView.setTitle(R.string.localizable.skipAdCount(Int(duration-current)), for: .normal)
                self.skipView.tg_width.equal(.wrap)
                self.skipView.setNeedsLayout()
            }
        })
        
        //显示图像
        playerLayer = AVPlayerLayer(player: player)
        
        //从中心等比缩放，完全显示控件
        playerLayer?.videoGravity = .resizeAspectFill
        
        view.layer.insertSublayer(playerLayer!, at: 0)
    }

    @objc func primaryClick(_ sender:QMUIButton) {
        next()
    }

    func startPlay()  {
        player?.play()
    }

    func pausePlay()  {
        player?.pause()
    }

    /// 进入前台了,第一次进入也会调用
    @objc func onEnterForeground() {
        startPlay()
    }

    /// 进入后台了
    @objc func onEnterBackground() {
        pausePlay()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pausePlay()
        self.player = nil
    }


    func showImageAd(_ data:String) {
        iconView.showLocal(data)
        CountDownUtil.countDown(5) { result in
            if result == 0 {
                self.next()
            }else {
                self.skipView.tg_width.equal(.wrap)
                self.skipView.setTitle(R.string.localizable.skipAdCount(result), for: .normal)
            }
            self.skipView.setNeedsLayout()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        iconView.frame = view.bounds
        playerLayer?.frame = view.bounds
    }
    
    @objc func tipClick() {
        //取消倒计时
        CountDownUtil.cancel()
        
        next()
        
        //通过这种方式，可以确保主界面显示了，然后在发送通知
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.EVENT_BANNER_CLICK), object: nil, userInfo: [Constants.DATA:self.data])
        }
    }
    
    lazy var tipView: QMUIButton = {
        let r = ViewFactoryUtil.primaryHalfFilletButton()
        r.tg_horzMargin(50)
        r.tg_height.equal(60)
        r.layer.cornerRadius = 30
        r.setTitle(R.string.localizable.adClickTip(), for: .normal)
        r.backgroundColor = .buttonTransparent88
        r.tg_bottom.equal(50)
        r.tg_centerX.equal(0)
        r.addTarget(self, action: #selector(tipClick), for: .touchUpInside)
        return r
    }()
    
    lazy var skipView: QMUIButton = {
        let r = ViewFactoryUtil.primarySmallHalfFilletButton()
        r.setTitle(R.string.localizable.skipAdCount(5), for: .normal)
        r.titleLabel?.font = UIFont.systemFont(ofSize: TEXT_SMALL)
        r.backgroundColor = .buttonTransparent88
        r.tg_top.equal(50)
        r.tg_right.equal(PADDING_OUTER)
        r.addTarget(self, action: #selector(primaryClick(_:)), for: .touchUpInside)
        return r
    }()

    lazy var iconView: UIImageView = {
        let r = UIImageView()
        r.contentMode = .scaleAspectFill
        return r
    }()
}
