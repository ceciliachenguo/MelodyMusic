//
//  DrawerController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 9/5/23.
//

import UIKit
import TangramKit

class DrawerController: BaseLogicController {
    
    override func initViews() {
        super.initViews()
        initScrollSafeArea()
        
        initUserView()
    }
    
    func initUserView() {
        let userContainer = TGRelativeLayout()
        userContainer.tg_width.equal(.fill)
        userContainer.tg_height.equal(.wrap)
        userContainer.tg_padding = UIEdgeInsets(top: PADDING_OUTER, left: PADDING_OUTER, bottom: PADDING_OUTER, right: PADDING_OUTER)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(userClick(_:)))
        userContainer.addGestureRecognizer(tapGestureRecognizer)
        
        userContainer.addSubview(iconView)
        
        userContainer.addSubview(self.nicknameView)
        
        let moreView = ViewFactoryUtil.moreIconView()
        moreView.tg_leading.equal(self.nicknameView.tg_right).offset(3)
        userContainer.addSubview(moreView)
        
        userContainer.addSubview(self.scanView)
        
        container.insertSubview(userContainer, at: 0)
        contentContainer.tg_space = PADDING_OUTER
    }
    
    @objc func userClick(_ data: UITapGestureRecognizer) {
        
    }
    
    lazy var scanView: QMUIButton = {
        let result = ViewFactoryUtil.button(image:R.image.scan()!.withTintColor())
        result.tintColor = .colorOnBackground
        result.tg_centerY.equal(0)
        result.tg_right.equal(0)
        result.addTarget(self, action: #selector(scanClick(_:)), for: .touchUpInside)
        return result
    }()
    
    @objc func scanClick(_ data:UITapGestureRecognizer) {
//        closeDrawer()
//        
//        #if targetEnvironment(simulator)
//        SuperToast.show(title: "模拟器不支持该功能，请在运行到真机测试")
//        #else
//            startController(ScanController.self)
//        #endif
    }
    
    lazy var iconView: UIImageView = {
        let r = UIImageView()
        r.tg_width.equal(30)
        r.tg_height.equal(30)
        r.image = R.image.defaultAvatar()
        r.smallCorner()
        r.tg_centerY.equal(0)
        r.contentMode = .scaleAspectFill

        return r
    }()
    
    lazy var nicknameView: UILabel = {
        let r = UILabel()
        r.tg_width.equal(.wrap)
        r.tg_height.equal(.wrap)
        r.tg_centerY.equal(0)
        r.text = "Nickname"
        r.font = UIFont.systemFont(ofSize: 16)
        r.textColor = .colorOnBackground
        r.tg_leading.equal(self.iconView.tg_right).offset(PADDING_MIDDLE)

        return r
    }()

}
