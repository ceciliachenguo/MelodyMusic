//
//  LoginController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 9/6/23.
//

import UIKit
import TangramKit

class LoginController: BaseTitleController {

    override func initViews() {
        super.initViews()
        initLinearLayoutSafeArea()
        
        title = R.string.localizable.login()
        
        container.tg_padding = UIEdgeInsets(top: PADDING_OUTER, left: PADDING_OUTER, bottom: PADDING_OUTER, right: PADDING_OUTER)
        container.tg_space = PADDING_OUTER
        
        container.addSubview(usernameView)
        container.addSubview(passwordView)
        
        //按钮
        let primaryButton = ViewFactoryUtil.primaryHalfFilletButton()
        primaryButton.setTitle(R.string.localizable.login(), for: .normal)
        primaryButton.addTarget(self, action: #selector(primaryClick(_:)), for: .touchUpInside)
        container.addSubview(primaryButton)
        
        let controlContainer = TGRelativeLayout()
        controlContainer.tg_width.equal(.fill)
        controlContainer.tg_height.equal(.wrap)
        container.addSubview(controlContainer)
        
        //立即注册按钮
        let registerView = ViewFactoryUtil.linkButton()
        registerView.setTitle(R.string.localizable.registerNow(), for: .normal)
        registerView.setTitleColor(.black80, for: .normal)
        registerView.addTarget(self, action: #selector(registerClick(_:)), for: .touchUpInside)
        registerView.sizeToFit()
        controlContainer.addSubview(registerView)
        
        //忘记密码按钮
        let forgotPasswordView = ViewFactoryUtil.linkButton()
        forgotPasswordView.setTitle(R.string.localizable.forgotPassword(), for: .normal)
        forgotPasswordView.setTitleColor(.black80, for: .normal)
        forgotPasswordView.addTarget(self, action: #selector(forgotPasswordViewClick(_:)), for: .touchUpInside)
        forgotPasswordView.sizeToFit()
        forgotPasswordView.tg_right.equal(0)
        controlContainer.addSubview(forgotPasswordView)
        
        initTapHideKeyboard()
//        
//        //swift中这样判断,需要在Build Settings 搜索 Other Swift Flags,设置Debug 添加 -D DEBUG
//        #if DEBUG
//        //添加测试账号，方便测试
//        usernameView.textFieldView.text="13141111222"
//        passwordView.textFieldView.text="ixueaedu"
//        #endif
    }
    
    @objc func primaryClick(_ sender:QMUIButton) {
//        //获取用户名
//        let username = usernameView.textFieldView.text?.trimmed
//        if SuperStringUtil.isBlank(username) {
//            SuperToast.show(title: R.string.localizable.enterUsername())
//            return
//        }
//        
//        //如果用户名
//        //不是手机号也不是邮箱
//        //就是格式错误
//        if !SuperRegularUtil.isPhone(username!) && !SuperRegularUtil.isEmail(username!) {
//            SuperToast.show(title: R.string.localizable.errorUsernameFormat())
//            return
//        }
//        
//        //获取密码
//        let password = passwordView.textFieldView.text?.trimmed
//        if SuperStringUtil.isBlank(password) {
//            SuperToast.show(title: R.string.localizable.enterPassword())
//            return
//        }
//        
//        //判断密码格式
//        if !StringUtil.isPassword(password!) {
//            SuperToast.show(title: R.string.localizable.errorPasswordFormat())
//            return
//        }
//        
//        //判断是手机号还有邮箱
//        let param = User()
//        param.password=password
//        if SuperRegularUtil.isPhone(username!) {
//            //手机号
//            param.phone = username
//        } else {
//            //邮箱
//            param.email = username
//        }
//        
//        //调用父类的登录方法
//        login(param)
    }
    
    @objc func registerClick(_ sender:QMUIButton) {
//        startController(RegisterController.self)
    }
    
    @objc func forgotPasswordViewClick(_ sender:QMUIButton) {
//        InputUserIdentityController.start(navigationController!, .forgotPassword)
    }

    //用户名输入框
    lazy var usernameView: SuperInputView = {
        let r = SuperInputView.input(placeholder: R.string.localizable.enterUsername(), image: R.image.inputUsername())
        r.smallBorder()
        
        return r
    }()
    
    //密码输入框
    lazy var passwordView: SuperInputView = {
        let r = SuperInputView.input(placeholder: R.string.localizable.enterPassword(), image: R.image.inputPassword())
        r.smallBorder()
        r.passwordStyle()
        
        return r
    }()
}
