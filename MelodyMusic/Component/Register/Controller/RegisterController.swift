//
//  RegisterController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 9/16/23.
//

import UIKit

class RegisterController: BaseLoginController {
    private var nicknameView:SuperInputView!
    private var phoneView:SuperInputView!
    private var emailView:SuperInputView!
    private var passwordView:SuperInputView!
    private var confirmPasswordView:SuperInputView!
    
    override func initViews() {
        super.initViews()
        initLinearLayoutSafeArea()
        
        title = R.string.localizable.registerNow()
        
        container.tg_padding = UIEdgeInsets(top: PADDING_OUTER, left: PADDING_OUTER, bottom: PADDING_OUTER, right: PADDING_OUTER)
        container.tg_space = PADDING_OUTER
        
        nicknameView = SuperInputView.input(placeholder: R.string.localizable.enterNickname())
        container.addSubview(nicknameView)
        
        phoneView = SuperInputView.input(placeholder: R.string.localizable.enterPhone()).phoneStyle()
        container.addSubview(phoneView)
        
        emailView = SuperInputView.input(placeholder: R.string.localizable.enterEmail()).emailStyle()
        container.addSubview(emailView)
        
        passwordView = SuperInputView.input(placeholder: R.string.localizable.enterPassword())
        passwordView.passwordStyle()
        container.addSubview(passwordView)
        
        confirmPasswordView = SuperInputView.input(placeholder: R.string.localizable.enterConfirmPassword())
        confirmPasswordView.passwordStyle()
        container.addSubview(confirmPasswordView)
        
        container.addSubview(primaryButton)
    }
    
    lazy var primaryButton: QMUIButton = {
        let r = ViewFactoryUtil.primaryHalfFilletButton()
        r.setTitle(R.string.localizable.registerAndLogin(), for: .normal)
        r.addTarget(self, action: #selector(primaryClick(_:)), for: .touchUpInside)
        return r
    }()
    
    @objc func primaryClick(_ sender:QMUIButton) {
        let nickname = nicknameView.textFieldView.text?.trimmed
        if SuperStringUtil.isBlank(nickname) {
            SuperToast.show(title: R.string.localizable.enterNickname())
            return
        }
        
        if !StringUtil.isNickname(nickname!) {
            SuperToast.show(title: R.string.localizable.errorNicknameFormat())
            return
        }
        
        let phone = phoneView.textFieldView.text?.trimmed
        if SuperStringUtil.isBlank(phone) {
            SuperToast.show(title: R.string.localizable.enterPhone())
            return
        }
        
        if !SuperRegularUtil.isPhone(phone!) {
            SuperToast.show(title: R.string.localizable.errorPhoneFormat())
            return
        }
        
        let email = emailView.textFieldView.text?.trimmed
        if SuperStringUtil.isBlank(email) {
            SuperToast.show(title: R.string.localizable.enterEmail())
            return
        }
        
        if !SuperRegularUtil.isEmail(email!) {
            SuperToast.show(title: R.string.localizable.errorEmailFormat())
            return
        }
        
        //获取密码
        let password = passwordView.textFieldView.text?.trimmed
        if SuperStringUtil.isBlank(password) {
            SuperToast.show(title: R.string.localizable.enterPassword())
            return
        }

        //判断密码格式
        if !StringUtil.isPassword(password!) {
            SuperToast.show(title: R.string.localizable.errorPasswordFormat())
            return
        }

        //确认获取密码
        let confirmPassword = confirmPasswordView.textFieldView.text?.trimmed
        if SuperStringUtil.isBlank(confirmPassword) {
            SuperToast.show(title: R.string.localizable.enterConfirmPassword())
            return
        }

        //判断确认密码是否一致
        if password != confirmPassword {
            SuperToast.show(title: R.string.localizable.errorConfirmPassword())
            return
        }
        
        let param=User()

        param.nickname=nickname
        param.phone=phone
        param.email=email
        param.password=password
        
        DefaultRepository.shared
            .register(param)
            .subscribeSuccess { data in
                //注册成功后，自动登陆，这样用户体验更好
                self.login(param)
            }.disposed(by: rx.disposeBag)
    }
}
