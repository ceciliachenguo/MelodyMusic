//
//  SuperSettingView.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 9/5/23.
//

import UIKit
import TangramKit

class SuperSettingView: TGLinearLayout {
    typealias ClickCallback = ((_ data:UIView)->Void)
    typealias SwitchChangedCallback = ((_ data:UISwitch)->Void)
    
    var click:ClickCallback?
    var switchChanged:SwitchChangedCallback?
    
    init() {
        super.init(frame: CGRect.zero, orientation: .horz)
        initViews()
        initListeners()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
        initListeners()
    }
    
    func initViews() {
        tg_width.equal(.fill)
        tg_height.equal(55)
        tg_padding = UIEdgeInsets(top: 0, left: PADDING_OUTER, bottom: 0, right: PADDING_OUTER)
        tg_gravity = TGGravity.vert.center
        tg_space = PADDING_MIDDLE
        backgroundColor = .colorSurface
        
        addSubview(self.iconView)
        addSubview(self.titleView)
        addSubview(self.textFieldView)
        addSubview(self.moreView)
        addSubview(self.moreIconView)
    }
    
    func initListeners() {
        isUserInteractionEnabled = true
        
        let tapGestureRecognizer=UITapGestureRecognizer(target: self, action: #selector(onTapClick(_:)))
//        tapGestureRecognizer.delegate=self
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func onTapClick(_ data:UITapGestureRecognizer) {
        if let r = click {
            r(data.qmui_targetView!)
        }
    }
    
    /// 没有水平内边距
    func noHorizontalPadding() {
        tg_padding = UIEdgeInsets.zero
    }
    
    /// 小容器样式
    func small() {
        tg_padding = UIEdgeInsets(top: 0,
                                  left: PADDING_OUTER,
                                  bottom: 0,
                                  right: PADDING_OUTER)
        tg_height.equal(50)
    }
    
    @discardableResult
    func minStyle() -> SuperSettingView {
        tg_padding = UIEdgeInsets(top: 0,
                                  left: 0,
                                  bottom: 0,
                                  right: 0)
        tg_height.equal(.wrap)
        
        titleView.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        
        return self
    }
    
    func initSwitch() {
        insertSubview(superSwitch, at: 3)
        moreIconView.hide()
    }
    
    lazy var iconView: UIImageView = {
        let r = UIImageView()
        r.tg_width.equal(20)
        r.tg_height.equal(20)
        r.tintColor = .colorOnBackground
        r.hide()
        return r
    }()
    
    lazy var titleView: UILabel = {
        let result=UILabel()
        //fill:暂用剩下所有空间
        result.tg_width.equal(.fill)
        result.tg_height.equal(.wrap)
        result.font = UIFont.systemFont(ofSize: TEXT_LARGE)
        result.tintColor = .colorOnBackground
        return result
    }()
    
    lazy var moreView: UILabel = {
        let result=UILabel()
        result.tg_width.equal(.wrap)
        result.tg_height.equal(.wrap)
        result.font = UIFont.systemFont(ofSize: TEXT_SMALL)
        result.tintColor = .lightGray
        result.textColor = .lightGray
        return result
    }()
    
    lazy var textFieldView: QMUITextField = {
        let result=QMUITextField()
        result.tg_width.equal(.wrap)
        result.tg_height.equal(.wrap)
        result.font = UIFont.systemFont(ofSize: TEXT_LARGE)
        result.tintColor = .colorOnBackground
        result.hide()
        return result
    }()
    
    lazy var moreIconView: UIImageView = {
        let result=ViewFactoryUtil.moreIconView()
        return result
    }()
    
    lazy var superSwitch: UISwitch = {
        let r = UISwitch()
        r.tg_width.equal(.wrap)
        r.tg_height.equal(.wrap)
        
        //开关状态为开的时候左侧颜色
        r.onTintColor = .colorPrimary
        
        r.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        
        return r
    }()
    
    @objc func switchChanged(_ sender:UISwitch) {
        if let r = switchChanged {
            r(sender)
        }
    }
}

extension SuperSettingView {
    //MARK: - 快捷创建控件
    static func smallWithIcon(icon:UIImage?=nil,
                              title:String,
                              click:@escaping ClickCallback,
                              switchChanged:SwitchChangedCallback?=nil) -> SuperSettingView {
        let r = SuperSettingView()
        
        //小容器
        r.small()
        
        if let icon = icon {
            r.iconView.show()
            r.iconView.image = icon
        }
        
        r.titleView.text = title
        
        r.click = click
        r.switchChanged = switchChanged
        
        if let _ = switchChanged {
            r.initSwitch()
        }
        
        return r
    }
    
    static func smallWithIcon(title:String,click: ((_ data:UIView)->Void)?=nil) -> SuperSettingView {
        let result = SuperSettingView()
        result.tg_height.equal(.wrap)
        result.tg_padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        result.iconView.hide()
        result.moreIconView.hide()
        
        result.titleView.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        
        result.titleView.text = title
        
        result.click = click
        
        return result
    }
    
    /// /// 图标，标题，开关效果（图片实现的）
    static func radioWithIcon(icon:UIImage,title:String,click:@escaping ((_ data:UIView)->Void)) -> SuperSettingView {
        let result = SuperSettingView()
        result.tg_padding = UIEdgeInsets(top: PADDING_MIDDLE, left: PADDING_OUTER, bottom: PADDING_MIDDLE, right: PADDING_OUTER)
        
        result.iconView.show()
        result.iconView.tg_width.equal(30)
        result.iconView.tg_height.equal(30)
        
        result.moreIconView.show()
        result.moreIconView.tg_width.equal(20)
        result.moreIconView.tg_height.equal(20)
        
        result.iconView.image = icon
        result.titleView.text = title
        
        result.moreIconView.image = R.image.check()
        
        result.click = click
        
        return result
    }
    
    
    static func create(title:String,click:@escaping ClickCallback,switchChanged:SwitchChangedCallback?=nil) -> SuperSettingView {
        let r = SuperSettingView()
    
        r.titleView.text = title
        
        r.click = click
        r.switchChanged = switchChanged
        
        if let _ = switchChanged {
            r.initSwitch()
        }
        
        return r
    }
    
    static func create(icon:UIImage,title:String,click:@escaping ((_ data:UIView)->Void),switchChanged:((_ data:UISwitch)->Void)?=nil) -> SuperSettingView {
        let result = SuperSettingView()
        result.tg_padding = UIEdgeInsets(top: PADDING_MIDDLE, left: PADDING_OUTER, bottom: PADDING_MIDDLE, right: PADDING_OUTER)
        
        result.iconView.show()
        result.iconView.image = icon.withTintColor()
        result.titleView.text = title
        
        result.click = click
        result.switchChanged=switchChanged
        
        if let _ = switchChanged {
            result.initSwitch()
        }
        
        return result;
    }
    
    static func createInput(_ title:String,placeholder:String?=nil) -> SuperSettingView {
        let result = SuperSettingView()
        result.tg_padding = UIEdgeInsets(top: PADDING_MIDDLE, left: PADDING_OUTER, bottom: PADDING_MIDDLE, right: PADDING_OUTER)
        
        //最小宽度
        result.titleView.tg_width.equal(.wrap).min(80)
        result.titleView.text = title
        
        result.textFieldView.show()
        result.textFieldView.placeholder = placeholder
        
        result.moreIconView.hide()
        
        return result;
    }
}
