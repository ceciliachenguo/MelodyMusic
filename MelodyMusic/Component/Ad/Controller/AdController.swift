//
//  AdController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 12/10/23.
//

import Foundation

class AdController: BaseLogicController {
    var data:Ad?
    override func initViews() {
        super.initViews()
        
        //图片广告
        view.addSubview(iconView)
        
        initRelativeLayoutSafeArea()
        
        //跳过广告按钮
        container.addSubview(skipView)
        
        //提示按钮
        container.addSubview(tipView)
        
        initTapHideKeyboard()
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
    
    @objc func primaryClick(_ sender:QMUIButton) {
        next()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        iconView.frame = view.bounds
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
