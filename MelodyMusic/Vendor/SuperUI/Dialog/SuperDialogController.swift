//
//  SuperDialogController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 9/6/23.
//

import UIKit
import TangramKit

class SuperDialogController: BaseController, QMUIModalPresentationContentViewControllerProtocol {
    var contentContainer:TGBaseLayout!
    var footerContainer:TGBaseLayout!
    var modalController:QMUIModalPresentationViewController!
    var buttons:Array<UIView> = []
    
    /// 是否显示输入框
    var isShowInput = false
    
    override func initViews() {
        super.initViews()
        view.layer.cornerRadius = SMALL_RADIUS
        view.clipsToBounds = true
        view.backgroundColor = .colorDivider
        view.tg_width.equal(.fill)
        view.tg_height.equal(.wrap)
        
        //内容容器
        contentContainer = TGLinearLayout(.vert)
        contentContainer.tg_width.equal(.fill)
        contentContainer.tg_height.equal(.wrap)
//        contentContainer.tg_space = PADDING_MIN
//        contentContainer.tg_padding = UIEdgeInsets(top: PADDING_OUTER, left: PADDING_OUTER, bottom: PADDING_OUTER, right: PADDING_OUTER)
        contentContainer.tg_gravity = TGGravity.horz.center
        view.addSubview(contentContainer)
        
        //标题
        contentContainer.addSubview(titleView)
        
        if (isShowInput) {
            let listContainer = TGLinearLayout(.vert)
            listContainer.backgroundColor = .colorBackground
            listContainer.tg_width.equal(.fill)
            listContainer.tg_height.equal(.wrap)
            contentContainer.addSubview(listContainer)
            
            //输入框
            listContainer.addSubview(textFieldView)
        }
        
        //底部容器
        footerContainer=TGLinearLayout(.horz)
        footerContainer.tg_space = PADDING_MIN
        footerContainer.tg_width.equal(.fill)
        footerContainer.tg_height.equal(.wrap)
        footerContainer.tg_top.equal(PADDING_MIN)
        contentContainer.addSubview(footerContainer)
        
        for it in buttons {
            footerContainer.addSubview(it)
        }
    }
    
    /// 设置取消按钮
    @discardableResult
    func setCancelButton(title:String,target:Any?=nil,action:Selector?=nil) -> SuperDialogController {
        return addButton(title:title,color:.colorOnSurface,target: target,action: action)
    }
    
    @discardableResult
    /// 设置警告按钮
    func setWarningButton(title:String,target:Any, action:Selector)->SuperDialogController {
        addButton(title: title, color: .warning,target: target,action:action)
        return self
    }
    
    @discardableResult
    /// 设置确认按钮
    func setConfirmButton(title:String,target:Any, action:Selector)->SuperDialogController {
        addButton(title: title, color: .primaryColor,target: target,action:action)
        return self
    }
    
    /// 添加按钮
    @discardableResult
    func addButton(title:String,color:UIColor,target:Any?=nil,action:Selector?=nil) -> SuperDialogController {
        let r = ViewFactoryUtil.button(title:title,color:color)
        
        if let action = action {
            r.addTarget(target, action: action, for: .touchUpInside)
        } else {
            r.addTarget(self, action: #selector(cancelClick(_:)), for: .touchUpInside)
        }
        
        r.tg_width.equal(.fill)
        r.tg_height.equal(BUTTON_LARGE)
        
        return add(r)
    }
    
    func add(_ data:UIView) -> SuperDialogController {
        buttons.append(data)
        return self
    }
    
    @objc func cancelClick(_ sender:QMUIButton) {
        hide()
    }
    
    func show() {
        modalController = QMUIModalPresentationViewController()
        modalController.animationStyle = .fade
        
        //边距
        modalController.contentViewMargins = UIEdgeInsets(top: PADDING_LARGE2, left: PADDING_LARGE2, bottom: PADDING_LARGE2, right: PADDING_LARGE2)
        
        //点击外部不隐藏
        modalController.isModal = true
        
        //设置要显示的内容控件
        modalController.contentViewController = self
        
        modalController.showWith(animated: true)
    }
    
    func hide() {
        modalController.hideWith(animated: true, completion: nil)
    }
    
    func setTitleText(_ data:String) {
        titleView.text = data
    }
    
    @discardableResult
    func titleInputConfirmStyle() -> SuperDialogController {
        isShowInput = true
        return self
    }
    
    private lazy var titleView: UILabel = {
        let r = QMUILabel()
        r.tg_width.equal(.fill)
        r.tg_height.equal(.wrap)
        r.contentEdgeInsets = UIEdgeInsets(top: PADDING_LARGE2, left: PADDING_OUTER, bottom: PADDING_LARGE2, right: PADDING_OUTER)
        r.backgroundColor = .colorBackground
        r.textAlignment = .center
        r.font = UIFont.systemFont(ofSize: TEXT_LARGE3)
        r.textColor = .colorOnSurface
        return r
    }()
    
    lazy var textFieldView: QMUITextField = {
        let r = QMUITextField()
        r.tg_width.equal(.fill)
        r.tg_height.equal(INPUT_MEDDLE)
        r.textInsets = UIEdgeInsets(top: 0, left: PADDING_MIDDLE, bottom: 0, right: PADDING_MIDDLE)
        r.font = UIFont.systemFont(ofSize: TEXT_LARGE)
        r.placeholder = "请输入内容"
        r.textColor = .colorOnSurface
        
        //编辑的时候显示清除按钮
        r.clearButtonMode = .whileEditing
        
        //关闭首字母大写
        r.autocapitalizationType = .none
        
        //小圆角，边框
        r.layer.cornerRadius = SMALL_RADIUS
        r.layer.borderWidth = 1
        r.layer.borderColor = UIColor.colorDivider.cgColor

        r.tg_horzMargin(PADDING_OUTER)
        r.tg_bottom.equal(PADDING_OUTER)
        return r
    }()
}
