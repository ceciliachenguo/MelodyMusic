//
//  DrawerController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 9/5/23.
//

import UIKit
import TangramKit
import DynamicColor

class DrawerController: BaseLogicController {
    
    override func initViews() {
        super.initViews()
        initScrollSafeArea()
        
        contentContainer.tg_padding = UIEdgeInsets(top: PADDING_OUTER, left: PADDING_OUTER, bottom: PADDING_OUTER, right: PADDING_OUTER)
        
        initUserView()
        initRecordView()
        initMessageMenu()
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
    
    func closeDrawer() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func scanClick(_ data:UITapGestureRecognizer) {
        closeDrawer()
        
        #if targetEnvironment(simulator)
        SuperToast.show(title: "模拟器不支持该功能，请在运行到真机测试")
        #else
            startController(ScanController.self)
        #endif
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

    func initRecordView() {
        let recordContainer = TGLinearLayout(.vert)
        recordContainer.tg_width.equal(.fill)
        recordContainer.tg_height.equal(.wrap)
        recordContainer.backgroundColor = .black42
        recordContainer.corner()
        recordContainer.tg_padding = UIEdgeInsets(top: PADDING_MIDDLE,
                                                  left: PADDING_MIDDLE,
                                                  bottom: PADDING_MIDDLE,
                                                  right: PADDING_MIDDLE)
        recordContainer.tg_space = PADDING_MIDDLE
        contentContainer.addSubview(recordContainer)
        
        //开通黑胶VIP，会员中心容器
        let vipContainer=TGRelativeLayout()
        vipContainer.tg_width.equal(.fill)
        vipContainer.tg_height.equal(.wrap)
        recordContainer.addSubview(vipContainer)
        
        //开通黑胶VIP
        let vipView = UILabel()
        vipView.tg_width.equal(.wrap)
        vipView.tg_height.equal(.wrap)
        vipView.text = R.string.localizable.buyVip()
        vipView.font = UIFont.systemFont(ofSize:TEXT_MEDDLE)
        vipView.textColor = .black183
        vipView.tg_centerY.equal(0)
        vipContainer.addSubview(vipView)
        
        //会员中心按钮
        let memberView = ViewFactoryUtil.secondHalfFilletSmallButton()
        memberView.setTitle(R.string.localizable.memberCenter(), for: .normal)
        memberView.setTitleColor(DynamicColor(hex: 0x837774), for: .normal)
        memberView.qmui_borderWidth = 1
        memberView.qmui_borderColor = .vipBorder
        memberView.tg_centerY.equal(0)
        memberView.tg_right.equal(0)
        vipContainer.addSubview(memberView)
        
        //加入黑胶vip提示
        let vipHintView = UILabel()
        vipHintView.tg_width.equal(.wrap)
        vipHintView.tg_height.equal(.wrap)
        vipHintView.text = R.string.localizable.vipHint()
        vipHintView.font = UIFont.systemFont(ofSize: 12)
        vipHintView.textColor = .vipBorder
        recordContainer.addSubview(vipHintView)
        
        //分割线
        let divderView = ViewFactoryUtil.smallDivider()
        divderView.backgroundColor = .divider2
        recordContainer.addSubview(divderView)
        
        //价格提示
        let priceHintView = UILabel()
        priceHintView.tg_width.equal(.wrap)
        priceHintView.tg_height.equal(.wrap)
        priceHintView.text = R.string.localizable.vipHintPrice()
        priceHintView.font = UIFont.systemFont(ofSize: 12)
        priceHintView.textColor = .vipBorder
        recordContainer.addSubview(priceHintView)
    }
    
    func initMessageMenu() {
        let itemContainer=TGLinearLayout(.vert)
        itemContainer.tg_width.equal(.fill)
        itemContainer.tg_height.equal(.wrap)
        itemContainer.backgroundColor = .colorDivider
        itemContainer.corner()
        itemContainer.tg_space = PADDING_MIN
        contentContainer.addSubview(itemContainer)
        
        itemContainer.addSubview(self.messgeView)
        
        //我的消息
        itemContainer.addSubview(self.messgeView)
        
        //我的好友
        var itemView = SuperSettingView.smallWithIcon(icon: R.image.scan()!, title: R.string.localizable.myFriend()) {[weak self] data in
            self?.closeDrawer()
//            self?.loginAfter {
//                guard let self = self else { return }
//                UserController.start(self.getNavigationController(), .friend)
//            }
        }
        
        itemContainer.addSubview(itemView)
        
        //我的粉丝
        itemView = SuperSettingView.smallWithIcon(icon: R.image.scan()!, title: R.string.localizable.myFans()) {[weak self] data in
            self?.closeDrawer()
//            self?.loginAfter {
//                guard let self = self else { return }
//                UserController.start(self.getNavigationController(), .fans)
//            }
        }
        itemContainer.addSubview(itemView)
        
        //二维码
        itemView = SuperSettingView.smallWithIcon(icon: R.image.scan()!, title: R.string.localizable.myCode()) {[weak self] data in
            self?.closeDrawer()
//            self?.loginAfter {
//                guard let self = self else { return }
//                self.getNavigationController().startController(CodeController.self)
//            }
        }
        itemContainer.addSubview(itemView)
    }

    lazy var messgeView: SuperSettingView = {
        let result=SuperSettingView.smallWithIcon(icon: R.image.scan()!, title: R.string.localizable.myMessage()) {[weak self] data in
            self?.closeDrawer()
        }
        
        return result
    }()


}
