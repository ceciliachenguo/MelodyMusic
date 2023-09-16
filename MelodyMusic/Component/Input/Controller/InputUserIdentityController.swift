//
//  InputUserIdentityController.swift
//  输入用户邮箱，手机号通用界面
//  主要用到手机号登录，找回密码时，输入手机号，输入邮箱
//  根据启动参数区分是那种功能
//  之所以设计为当前界面只是输入，下一个界面才发送验证码，原因是限制发送验证了
//  又更改了输入框的手机号，邮箱
//  Created by Cecilia Chen on 9/16/23.
//

import UIKit

class InputUserIdentityController: BaseTitleController {
    var style:MyStyle!

    override func initViews() {
        super.initViews()
        
        setBackgroundColor(.colorLightWhite)
        
        initLinearLayoutInputSafeArea()
        
        container.addSubview(usernameView)
        container.addSubview(primaryButton)
    }
    
    override func initDatum() {
        super.initDatum()
        switch style {
        case .phoneLogin:
            title = R.string.localizable.phoneLogin()
            
            usernameView.textFieldView.placeholder = R.string.localizable.enterPhone()
        default:
            //forget/reset password
            title = R.string.localizable.forgotPassword()
            
            usernameView.textFieldView.placeholder = R.string.localizable.enterPhone()
        }
    }
    
    lazy var usernameView: SuperInputView = {
        let r = SuperInputView.input(placeholder: R.string.localizable.enterPhone())
        r.textFieldView.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        
        return r
    }()
    
    lazy var primaryButton: QMUIButton = {
        let r = ViewFactoryUtil.primaryHalfFilletButton()
        r.setTitle(R.string.localizable.sendCode(), for: .normal)
        r.addTarget(self, action: #selector(primaryClick(_:)), for: .touchUpInside)
        r.isEnabled = false
        return r
    }()

    @objc func textChanged(_ sender:QMUITextField) {
        primaryButton.isEnabled = SuperStringUtil.isNotBlank(sender.text?.trimmed)
    }
    
    @objc func primaryClick(_ sender:QMUIButton) {
        let content = usernameView.textFieldView.text!.trimmed
        let isPhone = SuperRegularUtil.isPhone(content)
        if isPhone || SuperRegularUtil.isEmail(content) {
            
            let pageData = InputCodePageData()
            pageData.style=style
            if (isPhone) {
                pageData.phone=content
            } else {
                pageData.email=content
            }

            InputCodeController.start(navigationController!,pageData)
        } else {
            SuperToast.show(title: R.string.localizable.errorUsernameFormat())
        }
    }
}

extension InputUserIdentityController{
    static func start(_ controller:UINavigationController,_ style:MyStyle) {
        let target = InputUserIdentityController()
        target.style = style
        controller.pushViewController(target, animated: true)
    }
}
